# Notes on how bsv works

 - there's a standard library called prelude which needs to be imported. (don't know what it is yet).
 - You create an interface on what are the pins that are going to be accessed from outside the module.
 - Use the interface to set up the "action" of the interfaces.
 - Use another action to return the output of the "action". (which is another action).
 - To just compile it, use 
```bash
    bsc -u <package_name>.bsv
```
 - To translate the bsv file to verilog, use
 ```bash
    bsc -u -verilog -g <module_name> <package_name>.bsv
```
