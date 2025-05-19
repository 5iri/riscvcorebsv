# SHAKTI Cache Subsystem Deep Dive

## Introduction
- Provides a **detailed analysis** of the Shakti project’s cache subsystem in the `uncore/caches_mmu` GitLab repository.
- Explores the **structure and function** of:
  - Instruction cache (I-cache)
  - Data cache (D-cache)
- Examines any **cache coherence** mechanisms.
- Outlines **cache replacement** and **write policies**.
- Explains how caches **interface** with the **Memory Management Unit (MMU)** and the processor core.
- Discusses the **role of directories** (if implemented) in maintaining coherence.
- Includes a **study guide** listing:
  - Key concepts
  - Background knowledge
  - Recommended topics for a modern 5-stage pipelined RISC-V core
- Covers fundamentals such as:
  - Cache basics
  - Write policies
  - Coherence protocols
  - Memory-mapped I/O
  - Virtual memory
  - Verilog/SystemVerilog design patterns for caches & TLBs

---

## Cache Hierarchy Overview
- Modern CPUs use a **multi-level cache hierarchy**:
  - **L1** (per-core): split into I-cache & D-cache
  - **L2**: often unified and shared
- The Shakti repo’s BSV modules likely implement **L1** caches and **TLBs**.
- **Goals** of cache hierarchy:
  - Store frequently accessed data/instructions close to the core
  - Reduce average memory access time

### Instruction Cache (I-Cache)
- Holds recently executed instructions for the fetch stage
- Stores **cache lines** (blocks) of instructions from main memory
- Typical fields per line:
  - **Tag** (address bits)
  - **Valid bit** (indicates if data is current)
- **No dirty bit** (instructions rarely change)
- Often **set-associative**:
  - **Data array** + **Tag array**
  - Uses **index** (middle address bits) → selects set
  - Compares **tag** (upper bits) → hit/miss
- On **hit**: return data immediately  
- On **miss**:
  1. Send request to L2 or main memory
  2. FIFO queues pending requests (“icache pending_io fifo”)
  3. Stall pipeline until refill arrives
  4. Store new line, update tag & valid, resume fetch

### Data Cache (D-Cache)
- Speeds up data **loads** and **stores**
- Typical fields per line:
  - **Tag**
  - **Valid bit** (fresh data)
  - **Dirty bit** (modified, needs write-back)
- **Set-associative** structure similar to I-cache
- Operations:
  - **Load hit**: return data
  - **Load miss**: fetch line, possibly evict dirty line first
  - **Store hit**:
    - **Write-back**: update cache, set dirty
    - **Write-through**: update cache + memory, use write buffer
  - **Store miss**:
    - **Write-allocate**: fetch line, then write (common with write-back)
    - **No-write-allocate**: write directly to memory (common with write-through)
- Likely policy: **write-back, write-allocate**

---

## Instruction Cache (I-Cache) Design & Logic

### Structure & Function
- **Harvard architecture**: separate memory structures for I-cache vs D-cache
- Typically **physically indexed, physically tagged** (avoids synonyms)
  - MMU/ITLB must produce physical tag before compare
- **Request flow**:
  1. Core issues PC → I-cache address
  2. Tag lookup (after translation)
  3. **Hit** → single-cycle return
  4. **Miss** → send refill request, stall, queue via FIFO, update line on return

### Coherence Considerations
- **Single-core**: no coherence needed
- **Multi-core** or **self-modifying code**:
  - Must **invalidate** stale lines on code update or DMA
  - Use OS flush instructions or hardware protocol
- Shakti repo: no explicit MESI in L1 code → possibly handled at L2 or via software flush

### Replacement Policy
- On miss, choose a victim way:
  - **LRU** (complex hardware)
  - **Pseudo-LRU (PLRU)**
  - **Random/LFSR-based** (“specialfifo_lfsr_mod” commit)
- Likely uses **PLRU** or **LFSR** for simplicity

---

## Data Cache (D-Cache) Design & Logic

### Structure & Function
- Accessed in **Memory** stage of pipeline
- **Associativity & size** (e.g., 4-way, 32 KB, 64 B lines)
- **Fields**: data array + tag array (tag, valid, dirty)
- **Operations**:
  - **Load**: hit vs miss → stall & refill FSM
  - **Store**:
    - **Write-back**: update cache + dirty bit
    - **Write-through**: update cache + memory, use store buffer
    - **Miss**:
      - **Write-allocate**: fetch line, then write
      - **No-write-allocate**: write directly to memory
- Likely **write-back, write-allocate**

### Miss Handling FSM
- **Read miss**: if victim dirty → write-back → fetch new line
- **Write miss**: 
  1. Evict dirty line if needed
  2. Fetch new line
  3. Apply write, set dirty
- May use **store buffer** to queue write-backs or write-throughs

---

## Cache Coherence Strategies

### Snooping Protocols
- Broadcast on shared bus; caches snoop transactions
- **MESI** states:
  - **M** (Modified), **E** (Exclusive), **S** (Shared), **I** (Invalid)
- On write in **S**, issue **RFO** → others invalidate → go to **M**

### Directory-Based Protocols
- Central/distributed directory tracks sharers & owners
- On miss, directory:
  1. Invalidates or forwards as needed
  2. Updates sharer list
- Scales better to many cores

### Shakti’s Approach
- Possibly single-core L1 + coherent L2  
- Directory likely part of L2 or uncore interconnect  
- L1 receives invalidation commands from higher level

---

## Replacement Policy in D-Cache
- Likely **PLRU** (commit “plru dtlb fixes”)
- Could use **LFSR/random** (“specialfifo_lfsr_mod”)
- Eviction logic includes **dirty-line write-back**

---

## MMU Interface & Cache Operation

### Indexing & Tagging Choices
- **VIPT**: index by virtual bits, tag compare after translation (fast, needs alias control)
- **PIPT**: translate then access cache (simpler, extra latency)
- Shakti likely uses **PIPT** or **parallel VIPT** with page-offset indexing

### TLBs & Page-Table Walker
- Separate **ITLB** & **DTLB** modules (`itlb.bsv`, `dtlb.bsv`)
- **Page-Table Walker** (`ptw.bsv`) handles TLB misses:
  - Issues PTE loads via D-cache or bypass
  - FSM for multi-level walk

### Access Sequence (Load/Store)
1. Core issues virtual address
2. **DTLB** lookup:
   - **Hit** → physical address
   - **Miss** → PTW → refill DTLB
3. **D-cache** lookup with physical address (parallel or serial)
4. Return data or handle miss

---

## Memory-Mapped I/O (MMIO) Considerations
- MMIO regions are **uncacheable**
- Cache controller must **bypass** or **treat accesses as non-cacheable**
- OS/MMU marks pages as I/O
- Use **memory barriers** (RISC-V `FENCE`) to order MMIO writes/reads

---

## Write Policies & Memory Ordering
- **Write-Through**: updates cache + memory immediately (use write buffer)
- **Write-Back**: updates cache + marks dirty, defers memory write until eviction
- Shakti likely uses **write-back** at L1
- **Write-allocate** policy on store miss
- Honor RISC-V **fence** instructions for ordering

---

## Role of Directories in Coherence (If Implemented)
- Directory may reside in **L2** or separate controller
- Tracks which L1 caches hold each block & in what state
- On L1 miss:
  1. Query directory
  2. Invalidate or forward data
  3. Update directory entry
- Scalable vs snooping for many cores

---

## Verilog/SystemVerilog (BSV) Implementation Patterns
- **Modules**: `mkICache`, `mkDCache`, `mkTLB`, etc.
- **FSMs**: states for IDLE, LOOKUP, MISS, REFILL, WRITEBACK
- **Handshakes**: ready/valid or method calls stall pipeline on miss
- **SRAMs**: data & tag arrays via `RegFile` or inferred BRAM
- **AXI/custom bus**: decoupled `Put`/`Get` interface for memory
- **Parameterization**: line size, sets, ways via type parameters
- **Clock gating**: power optimization (commit “clock gating attributes for iobuffer”)

---

## Summary of Shakti Cache Subsystem
- **L1 I-Cache**: set-assoc., physically tagged, valid bits only, ITLB translation, FIFO for misses
- **L1 D-Cache**: set-assoc., write-back/write-allocate, valid & dirty bits, DTLB translation, miss FSM & store buffer
- **Coherence**: snooping or directory at higher level; L1 invalidations via uncore interconnect
- **MMU & TLBs**: physically addressed, separate ITLB/DTLB, hardware PTW
- **Memory Interface**: burst line requests to L2/main memory, refill logic in BSV

---

## Study Guide: Concepts & Background Knowledge

1. **Cache Basics & Hierarchy**
   - Purpose: exploit locality, improve CPI
   - Levels: L1 (I/D), L2, L3
   - Mappings: direct, set-assoc., fully assoc.
   - Address split: **Tag**, **Index**, **Offset**
   - Cache lines: 32–128 B
   - Miss types: compulsory, capacity, conflict

2. **Write Policies & Operations**
   - **Write-Through** vs **Write-Back**
   - **Write-Allocate** vs **No-Write-Allocate**
   - Read/write buffers, MSHRs
   - Refill & eviction sequence

3. **Replacement Algorithms**
   - **LRU**, **PLRU**, **Random/LFSR**, **FIFO**, **MRU**

4. **Cache Coherence Protocols**
   - **MESI** states & transitions
   - **MSI**, **MOESI**
   - **Snooping** vs **Directory**
   - Memory barriers & consistency

5. **Memory-Mapped I/O**
   - Uncacheable regions
   - OS/MMU page attributes
   - FENCE for ordering

6. **Virtual Memory, MMU & TLBs**
   - Virtual → Physical via page tables (Sv39)
   - **ITLB** & **DTLB** design
   - Hardware page-table walker vs software trap
   - TLB shootdowns (SFENCE.VMA)

7. **Pipeline Considerations**
   - 5-stage pipeline: Fetch, Decode, Execute, Memory, Writeback
   - Cache stalls → inject bubbles
   - Bypassing/forwarding for hazards
   - Exception & fault handling in cache/MMU

8. **HDL/BSV Patterns**
   - FSM design
   - Synchronous RAM inference
   - Module interfaces & parameterization
   - Ready/valid handshakes, stall logic
   - Reset/invalidate mechanisms

9. **Additional Topics**
   - Cache performance tuning (line size, associativity)
   - Inclusive vs exclusive multi-level caches
   - CPI impact & effective memory latency
   - Bluespec scheduling & rule semantics

---

## Conclusion
- The Shakti cache subsystem integrates:
  - **Caching** (I-cache, D-cache)
  - **Coherence** (snooping/directory)
  - **Memory management** (MMU, TLBs)
  - **BSV design patterns** (FSMs, parameterization)
- Mastery of the **study guide topics** will enable deep understanding and effective contribution to the Shakti `caches_mmu` repository.

