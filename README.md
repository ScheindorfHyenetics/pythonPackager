Python program running with python 2 or 3, able to take an header text file and a few another arbitrary files,
and then output on stdout a fully functional python script containing the choosen files lzma compressed and base64 encoded;
and the required script to manage unpacking one or all files from it.

ECDSA signature is currently mainly NOT IMPLEMENTED. 
Everything is just placeholders for signing archive and verify the token at decompression. Nothing is actually done.

Gzip compression is NOT IMPLEMENTED. Option is just a placeholder yet.

Everything else is working. 

-Can run exactly the same with python2 or python3
-Can load lzma library packed along an archive on the fly if unpacker's python doesn't have it
-Unpacked filed integrity is checked again sha512 hash

sample.py is packer.py file archived with himself.
packer.py is the packaging software

---

usage: packer.py [-h] [--packmodule {backports.lzma,ecdsa}] [--nointegrity]

                 [--hashname {hashlib.sha512}] [--compression {lzma,gzip}]

                 [--ecdsasign] [--ecdsaprivkey ECDSAPRIVKEY]

                 "header text file" "packed file" ["packed file" ...]


generate a python script containing compressed base64 version of mentioned

files, followed by a deflating script


positional arguments:

  "header text file"    file containing text displayed as header when using

                        unpacker without arguments

  "packed file"         a file to include in the package



optional arguments:

  -h, --help            show this help message and exit

  --packmodule {backports.lzma,ecdsa}, -I {backports.lzma,ecdsa}

                        package this module along generated python script and

                        import it as fallback

  --nointegrity, -H     desactivate attempt to include secure hash of packed

                        files and checking in unpacker

  --hashname {hashlib.sha512}, -S {hashlib.sha512}

                        secure hash algorithm to attempt to use for integrity

                        checking

  --compression {lzma,gzip}, -z {lzma,gzip}

                        compression algorithm to use for deflating files

  --ecdsasign, -e       activate attempt to create/load ecdsa key and sign

                        header+packaged datas with it PEM of key is output on

                        stderr

  --ecdsaprivkey ECDSAPRIVKEY, -k ECDSAPRIVKEY

                        private ecdsa key to use for signature, a new one is

                        generated if no specified






*


exemple packed script output with no args


hyena tmp # python pack.py

Imported lzma module (python3.4 standard lib)

magnifique paquet que je vous sers la

to unpack one of these files enter :

 |  pack.py  pythonpacker.forktestpackedmodules.py

 |  pack.py  pythonpacker.py

 |  pack.py  pythonpackedmodules.py

 | or

 | pack.py unpack all

 |    to unpack every files in /tmp/ if no file with

 |    identical name already exists.

 |    (please remove them or move them before)

