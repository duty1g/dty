# dty

it's a windows tiny lightful reverse shell project (6kb) and fully undetectable

the origin of this idea was a windows machine i was doing on pentest mission and there was an **RCE** with limitations -no spacing filter/race conditions-

# Usage
> so you can pass your IP and PORT parameters from filename example : dty_127.0.0.1_120.exe
> PS: dty is mandatory in filename

```
C:\Users\duty\Desktop>dty_10.10.14.1_120.exe -h
        ___ _
       /   \ |_ _   _
      / /\ / __| | | |
     / /_//| |_| |_| |
    /___,'  \__|\__, |
                |___/
                   v1.0
    tiny reverse shell by @duty
    [!] Use filename as paramaeters exapmle:
    dty_127.0.0.1_120.exe
```

# Features 

- detachable process (after running it you can still run other commands on the first shell that you have)
- race conditions / space filter bypass
- lightweight
- FUD (fully undetectable) [VirusTotal](https://www.virustotal.com/gui/file/a1e6cd61c98c5992ee9fff10d4f51b534878a0ee159b6dbc77380029696d7adf/detection)
- connection stat in CLI screen

# Download

you can download the latest version on relase tab 

# License

MIT - See License.md
