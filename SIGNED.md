##### Signed by https://keybase.io/clcollins
```
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlcHvg0ACgkQte6EFif3vzc0bQCgl4AbtkVVn1u6ktJl9emzcpee
1BAAoNLLNVtZsppTs7ElHk1YC27vhfNw
=oBPn
-----END PGP SIGNATURE-----

```

<!-- END SIGNATURES -->

### Begin signed statement 

#### Expect

```
size   exec  file                  contents                                                        
             ./                                                                                    
6555           LICENSE             36ffd9dc085d529a7e60e1276d73ae5a030b020313e6c5408593a6ae2af39673
2344           README.md           8563b60bf3a2142c4c227b88477b42c9d03aebb1d3c3d3ba38994c4f2b76372e
               redis/                                                                              
942              Dockerfile        37ce035345284e66578e929151467420a9eb796533ab9b745db84a5f0a8e6e4d
849    x         build-rpm.sh      442b21df55c53eb52029b9c9c57bedb62398db89589501533e9156c8fd5bf67a
36193            redis.conf        ad61801f3fe392098efcc2ba763843b697218039200334df40e7746aefc73ec3
89               redis.run         cd0f828f8b5ae34e73d14501229c422052b3d0f27d8d6fb8ae1064752c589b1c
               registry/                                                                           
121              Dockerfile        51e88b90cecc4aad3ac33283a8786c1130d241898bde4690f44f7001bc4cc781
639              config.yml        1588907a7de3bcd1076966884bebb2012348ae28623316ca774221af1c635fca
               web/                                                                                
2429             Dockerfile        ed76a8ead9263e527054aa45b5032b7a775101da8e61c083b8a7d8452a5a71b5
1276             apache-config.sh  d730c77b92f4963ce56176da4bd7c62a6f6f87421bce5e0c7cd5e3dac9208ced
849    x         build-rpm.sh      442b21df55c53eb52029b9c9c57bedb62398db89589501533e9156c8fd5bf67a
822              httpd.run         5e30dfe310597097dceadf742fa4182c4fdf1133839d3656f4abfd8b898f8fe5
751              krb5.conf         3566dd70d83ddccdb659721a297e5776b90f1d46e834a90ee79b674a7b623cb6
1522             vhost.conf        e9f5ff8491f3ffa695f4587720c96fb5c645b0f90b7a47ba035b055db037f111
```

#### Ignore

```
/SIGNED.md
```

#### Presets

```
git      # ignore .git and anything as described by .gitignore files
dropbox  # ignore .dropbox-cache and other Dropbox-related files    
kb       # ignore anything as described by .kbignore files          
```

<!-- summarize version = 0.0.9 -->

### End signed statement

<hr>

#### Notes

With keybase you can sign any directory's contents, whether it's a git repo,
source code distribution, or a personal documents folder. It aims to replace the drudgery of:

  1. comparing a zipped file to a detached statement
  2. downloading a public key
  3. confirming it is in fact the author's by reviewing public statements they've made, using it

All in one simple command:

```bash
keybase dir verify
```

There are lots of options, including assertions for automating your checks.

For more info, check out https://keybase.io/docs/command_line/code_signing