From: kbuild test robot <lkp@intel.com>
Date: Fri, 20 May 2016 10:27:33 +0000
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
Message-Id: <201605201833.ecqQBWwU%fengguang.wu@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
List-Id: <sparclinux.vger.kernel.org>
References: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
To: sparclinux@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

[auto build test ERROR on v4.6-rc5]
[cannot apply to next-20160519]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/zengzhaoxiu-163-com/lib-GCD-add-binary-GCD-algorithm/20160428-195527
config: mips-jz4740 (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

Note: the linux-review/zengzhaoxiu-163-com/lib-GCD-add-binary-GCD-algorithm/20160428-195527 HEAD 35e1a24e8fc3a5308b053ed3c744f02ec2a76820 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from arch/mips/include/asm/bitops.h:21:0,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/asm-generic/bug.h:13,
                    from arch/mips/include/asm/bug.h:41,
                    from include/linux/bug.h:4,
                    from include/linux/page-flags.h:9,
                    from kernel/bounds.c:9:
   arch/mips/include/asm/cpu-features.h:205:28: warning: "cpu_data" is not defined [-Wundef]
    # define cpu_has_mips32r6 (cpu_data[0].isa_level & MIPS_CPU_ISA_M32R6)
                               ^
   arch/mips/include/asm/cpu-features.h:241:5: note: in expansion of macro 'cpu_has_mips32r6'
        cpu_has_mips32r6 | cpu_has_mips64r1 | \
        ^
   arch/mips/include/asm/cpu-features.h:289:25: note: in expansion of macro 'cpu_has_mips_r'
    #define cpu_has_clo_clz cpu_has_mips_r
                            ^
   arch/mips/include/asm/cpu-features.h:291:6: note: in expansion of macro 'cpu_has_clo_clz'
    #if !cpu_has_clo_clz
         ^
>> arch/mips/include/asm/cpu-features.h:205:36: error: token "[" is not valid in preprocessor expressions
    # define cpu_has_mips32r6 (cpu_data[0].isa_level & MIPS_CPU_ISA_M32R6)
                                       ^
   arch/mips/include/asm/cpu-features.h:241:5: note: in expansion of macro 'cpu_has_mips32r6'
        cpu_has_mips32r6 | cpu_has_mips64r1 | \
        ^
   arch/mips/include/asm/cpu-features.h:289:25: note: in expansion of macro 'cpu_has_mips_r'
    #define cpu_has_clo_clz cpu_has_mips_r
                            ^
   arch/mips/include/asm/cpu-features.h:291:6: note: in expansion of macro 'cpu_has_clo_clz'
    #if !cpu_has_clo_clz
         ^
   make[2]: *** [kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +205 arch/mips/include/asm/cpu-features.h

0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  199  # define cpu_has_mips32r1	(cpu_data[0].isa_level & MIPS_CPU_ISA_M32R1)
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  200  #endif
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  201  #ifndef cpu_has_mips32r2
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  202  # define cpu_has_mips32r2	(cpu_data[0].isa_level & MIPS_CPU_ISA_M32R2)
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  203  #endif
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  204  #ifndef cpu_has_mips32r6
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13 @205  # define cpu_has_mips32r6	(cpu_data[0].isa_level & MIPS_CPU_ISA_M32R6)
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  206  #endif
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  207  #ifndef cpu_has_mips64r1
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  208  # define cpu_has_mips64r1	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R1)
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  209  #endif
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  210  #ifndef cpu_has_mips64r2
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  211  # define cpu_has_mips64r2	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R2)
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  212  #endif
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  213  #ifndef cpu_has_mips64r6
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  214  # define cpu_has_mips64r6	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R6)
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  215  #endif
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  216  
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  217  /*
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  218   * Shortcuts ...
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  219   */
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  220  #define cpu_has_mips_2_3_4_5	(cpu_has_mips_2 | cpu_has_mips_3_4_5)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  221  #define cpu_has_mips_3_4_5	(cpu_has_mips_3 | cpu_has_mips_4_5)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  222  #define cpu_has_mips_4_5	(cpu_has_mips_4 | cpu_has_mips_5)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  223  
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  224  #define cpu_has_mips_2_3_4_5_r	(cpu_has_mips_2 | cpu_has_mips_3_4_5_r)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  225  #define cpu_has_mips_3_4_5_r	(cpu_has_mips_3 | cpu_has_mips_4_5_r)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  226  #define cpu_has_mips_4_5_r	(cpu_has_mips_4 | cpu_has_mips_5_r)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  227  #define cpu_has_mips_5_r	(cpu_has_mips_5 | cpu_has_mips_r)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  228  
2d83fea7 arch/mips/include/asm/cpu-features.h Maciej W. Rozycki 2015-04-03  229  #define cpu_has_mips_3_4_5_64_r2_r6					\
2d83fea7 arch/mips/include/asm/cpu-features.h Maciej W. Rozycki 2015-04-03  230  				(cpu_has_mips_3 | cpu_has_mips_4_5_64_r2_r6)
2d83fea7 arch/mips/include/asm/cpu-features.h Maciej W. Rozycki 2015-04-03  231  #define cpu_has_mips_4_5_64_r2_r6					\
2d83fea7 arch/mips/include/asm/cpu-features.h Maciej W. Rozycki 2015-04-03  232  				(cpu_has_mips_4_5 | cpu_has_mips64r1 |	\
2d83fea7 arch/mips/include/asm/cpu-features.h Maciej W. Rozycki 2015-04-03  233  				 cpu_has_mips_r2 | cpu_has_mips_r6)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  234  
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  235  #define cpu_has_mips32	(cpu_has_mips32r1 | cpu_has_mips32r2 | cpu_has_mips32r6)
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  236  #define cpu_has_mips64	(cpu_has_mips64r1 | cpu_has_mips64r2 | cpu_has_mips64r6)
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  237  #define cpu_has_mips_r1 (cpu_has_mips32r1 | cpu_has_mips64r1)
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  238  #define cpu_has_mips_r2 (cpu_has_mips32r2 | cpu_has_mips64r2)
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  239  #define cpu_has_mips_r6	(cpu_has_mips32r6 | cpu_has_mips64r6)
c46b302b arch/mips/include/asm/cpu-features.h Ralf Baechle      2008-10-28  240  #define cpu_has_mips_r	(cpu_has_mips32r1 | cpu_has_mips32r2 | \
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13 @241  			 cpu_has_mips32r6 | cpu_has_mips64r1 | \
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  242  			 cpu_has_mips64r2 | cpu_has_mips64r6)
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  243  
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  244  /* MIPSR2 and MIPSR6 have a lot of similarities */

:::::: The code at line 205 was first introduced by commit
:::::: 34c56fc1c167facc375d927687df0a3891d164ac MIPS: asm: cpu: Add MIPSR6 ISA definitions

:::::: TO: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
:::::: CC: Markos Chandras <markos.chandras@imgtec.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--mP3DRpeJDSE+ciuQ
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICO/lPlcAAy5jb25maWcAlFxbc9u4kn6fX6HK7MM5VWcmtuwoyW75ASRBCSOSoAFSF7+w
HEfJqMaXrC3POfPvtxu8AWSDnn2JI3Tj1mg0vm40+PNPP8/Y6+np4fZ0vLu9v/9r9v3weHi+
PR2+zr4d7w//M4vkLJPFjEei+BWYk+Pj63/ePxx/vMwuf138evbL892H2frw/Hi4n4VPj9+O
31+h9vHp8aeffwplFotllYpcX/31ExT8PEtv734/Ph5mL4f7w13D9vPMYqxYEq54up8dX2aP
TydgPPUMTH2ky4vV/IOP8vEzSQlMb0uecSVCmiNMLz/udj7a4sJDMw2HMmBJQdNZuKoiHuqC
FUJmfp7f2M2NnyoyGLxn6AnLCnHtIWk2Ma5EymypZXYxf5tncennyQVML1wJ6WfZiSTOl8wv
wxQk6CHXXYS+UWJtzVl0QZIzHkILas1Fpv3Nb9TluWeFs11e6SKYz8+mybRO5il0r3OSplgi
srVNagh6KSqRz+ewkTrmpozeEw3x0wTRIz0tgn3Bq1CtRMYnOZhKefJGG3K6jTcZ9BZ6mWJI
RFEkXJdqshWeFVLTytSwBGLpbSQTlWcQRlWK3cVnnzGo6ZdeulgrWYh1pYIPnvUI2UaUaSXD
gsus0pLe8lmSVrtEVYFkKprgyCc4zL7JmYIOVUEoodpqnrY2s9K5yBIZrm2VZAqmu2K6Eolc
zqvSM6Uhm2tJGqa2n9WWi+WqgG4GhBA2S6AYrF3EE7bvGTQcIVElU1FUsWIpr3IpsoKrniPe
4hj63yHfFJW6XFslWoVuSW3XccbVRu819J6Mph6lrGJRpKqiWlwGghKi4dNlnktV6KrMlQy4
7nvBFjKZhXLFFShtT8g4zAmpKUPzAtO2e28MZujds5mshMQ+sf6EtIVm2MtY2g2hHXoVKLnm
Wc/X0lkuLCnmJW6simeRYBYzyK+XgcPgzmhVLnlVJEHLTFnGLchDSFBHFnKrBzBxRsOyaB/J
5ZiwYsl8XKo5vx6XbqPPF+PSG9ReosdPZ5dWyxGPWZkUhgx7qxB46A818cKqEEhZVDyJ7TIj
jOQcVB5Uu9IrERfVx0ny1UdHNQGQZFomnFbICrQwhc3UwjRYNgeiWaupLndnZ/Y6mcIPZ2dn
1NrstRGJXZEiYXWPclzMYRtVa64ynnhYzE4bsWDDb7TisPyNVlAbc7bkHZxtgO/prx+HXkqm
L1tCI0vQUdYbMKcl15ReY0dwNt3w6nId2M31hPPFOqAhRseyuHRZWq2TKuRgCXbVDZy/UkVg
HM/Pew2EEwKsKGqTtcEBftTyGBCwrLUSUZnmuGFdKtjRKs7LcWGtsCN+tHUaTZYGnFYY7ZYK
tDwENa29CYvZbNt9ZllzY2LjhBUpHFc8Y0FijbYpdwugrwjkAexgHXvSim1MadCcc1RxU9Wu
Vh8FAuQEYrSqd+tjGsB9jj2KLJamEWoD5QBvqrwwHcFk9dWltfNkCjbP60PkK9gkbxxGuPrG
aoMQlldnbTGe/1Uhq6DU9rDXOiXaaA1cigdTKjLT59Xl2eeFc3TlXJnlWqeO9Ug4y4wWkHOI
lcwKtPA0MkppRHeTS0nj0pugpKHPDWhakniwlYgSXu+pQrFwDZ4Xyba6qea0SwSUy0+E6KD8
3LWmWOIB7dj8B9rjMKSFj3Q+MM4ubU5hL8e+MoWWcXVjbYCbK2jUAsgGcK3gcAvXtC4qztMc
t1lGqXlL3sikzAqm9o69q4m0AeU7Tq9ZqJheGXNETY+HuHlGcENezMFOLS4n4EaNAtMI/DSO
6pmafZxIFtn4EvdrxPO2HevgAq94jVrExzRjFcAY8SzcF5KonC8LtGVVwjc80Vdzawe2/YLb
ffXu/f3xy/uHp6+v94eX9/9VZgiBFYedpvn7X+9MlOZdZ9XVdbWVyrJuQSmSqBBQh+/q/nQ9
CnPkLU186B5F8vqjP/RqNFihg5JallBkoDk824AO4eAAkV9ddMMGa661sWICDPS7d65lg7Kq
oI9GkC5LNlxpRFJ2PZtQsbKQE+ZqJXWBkrl694/Hp8fDPzuJoLlxkMZG5OGoAP+GhYUUcqnF
rkqvS15yunRUpRYAnAFS7StWYMDEOpZWLIsSB+SXmgNIoyBcGYluhWBFZy+vX17+ejkdHvoV
6nA8LLhxOgiIDyS9kluaAr6FvbJQEsmUCQe096Ug56BcEmNFFgM/oqpYKc4iMKeDo9M4WVqW
iFEiVhDOiFFPywsbkE0DsEng7CCIqUS/K6o9KCOy4vhweH6hpAYmEg4uISMR2vMEaAIUPBd8
ztaKDt2twJWFvajNDJQTfmqR9/vi9uWP2QmGNLt9/Dp7Od2eXma3d3dPr4+n4+P3fmxobc2R
ysCagd2sBdl1ZQ5xl4wyoE84WBQj056XWLpAR6g6IQetBUYH5A5p1eaCaKFgeo2+q7UsWFQ7
8G2bNmFHlIGz58zYCE6F5UyP1w9Y9hXQ7KHCTzBtsKykOzlgNiPGKnS8DpqC+SQJmqzUA8QK
OMAMp7H73nZwSLCNa2BIR53RMoO7nM09OGVd/4c0mVg9bnzD84/DTVGf4KGLc8OlkmXuQEAw
ViGNfoJk3VQguq8JdS+WiWNCVS6lPwJiXQVgAbciKla0zAq7Lg0CaoZcRHSgt6HHsEA3XFHj
BsjNbW1FFcf2Gooz4rqxiG+EZ5UbDqiKWj05Yq7iKfrIuPYMKx6uTbwLzUwhFYW38Nwz8RJr
ZiUgvcz6jWec/Rumq5wClELmKEfGAeHRkq71C4/kkYr0PHsNiw6wSfEQjHNEDFy5gT7UOZC3
gRnKUizzm6XQWn2KIEhoW4iq5Y19kEFBAAVzpyS5sUNgULC7GdDl4PeltW3CSuZgTdH/hpPO
OOIOfnBAAANMDAMG/08PmcAkhDxHB682HdbE89gWvNeapYB0BK6cHabiRYpmdHR61vInQpvN
aBoK0c0aivU+tSbQllSDpvryQAPYB2sHI8dwk79RMAPa4FdWiI0NrRQouYNbLRzBkxhMsrJF
hq3EpT3hGPrfWXVy6YhDLDOWxJZamTPbLjAQI3bsFqzMhKD0ygk9MGGpEYs2QvO2srOxcAUN
ao2pTYERBqaUMKvc60Qa8Cgid5FxNNDEVEOMZAqht2pTu8ODQFd+eP729Pxw+3h3mPE/D48A
TBhAlBChCQCo/th1G+/GZMzWqBNihJu0rl2ZYx6AkrUsSRnUDTnGF2MhGJSm/U+dMAo3Y1sD
RS94ajBnBW6EiEU4uqPtD4JYJAPIJetSyuQambd0a5908f+ukd8whAbj9VytNTcGNLrETupA
JktAfdHkhgjJfPcQuAqIKgAmAYJzHJ+14sXwcsK0v6ZLfeymH2O+VlIOg2gYeoLfhViWsiSw
OjiTdfSldhWI2iwXnTaMuu1FOfAwtgx0C0+4nClUxMaXJJpoQgUVLJtzg+QrNzXhBDCOPgik
4CEcwo6qDokU7hjymMjJZCtgIZdlwugbzDG3LpQkQX49AVgT8P67eNdgfh7XYsBFOBXDGKqM
GinnPMTd1tOBVCbgJ6GGojFXozXEuK+hAEqUqXPGAo7NQLFh7FumImd3mfCyrHgMvQm0MHE8
9sKWodz88uX25fB19kdt+X48P3073tfuV9cWsjU3BtPXnIax2fsVfTIYeXRRdLMthjeAaMQw
WGwhjwJOeFgoe9OZc85EM/t4biNMB8ibouYiAMNX1MFS85QZ0odL01TtiHbLzX7yZFfU1cHR
6iI1CS2/llPQULch4zZUtI1rlch4YAmYn9IycIOgfhJELB5Dy0AvycL6tszxfmokWvClEgWd
wGR8pCZ2aCyPGqlefvt8OuK126z468fBPlLbu0MECiwLXXeJAdjJeh5aHcWO5mhPLx1TN5Qs
FUvmEPoWC6bEZJspC6k2Ux1JTREwjBAJvR4Y7RQQ/a7SZUBUARwJo9DV7tOCarGEmmAFuNNs
HzGM0snxD29t+2M4KdQb8tRlRg1ozVTKKAKPPX1hyHHx6Y3VtfRqzFUHBuVM3/1+wLCwjdWE
rJ2zTEo7vteURnDsYrtjShhfu9iujqu2FSZCr56aOICJWk2/V+/uvv1vH77OzKQxF8WYonCN
x47tCRo6goeGPkUj624VBmU8lW2iW7sJKrQIOnh9mT39wI39MvtHHop/zfIwDQX714wLDf+a
f4rwn1bocVsfcUBxcL1w85jaHZJa16vi0/yDlbCQh3gTaf/Gnoe/zSlQhaK73c7DX+5un7/O
vjwfv343psgU8/8c7l5Pt1/uDyZFdGY8gpOlUHhIpSaFYXBi94RxAgs6a/XtcbveyLbieK9C
mfamLR0qkTthmBq6yZJyh5tKqdB27g/0jB1bfp4CQdTuXy+Mp38fnmfg+tx+PzyA59MuZj/t
+rQXAeAB4zRg7F8L5+65yf0BtJNFBLmhjAosXbICyV1HlHeSAlrg3LnhgjKMv5hy+pIuBVy8
5ib4TrY5aM0fhNpew+y2XFkwq1lV340agE2cTlL72FdWHkot+LQTfKuGSBNf7w82IENw5w3K
G+HXmQUtH7qXeUL6yBl3cq8KzLdFlNEOLTuc/v30/AcgwrEm5AA83dhgXQJHEKMgNx5RztmC
h52HdxcrK4CAvwA+LeWgqAn5dC2aQjg+YVkSEdLgxPDAWY8ZdX4Gk7WsCxHS4A4lteZ7YuDC
kajI69hUyLRb2oKbSsEWdich0NsKYHcKboZBKWnbbo4+I15eOhHNutGGgxUrggaYNJDaSXup
8iwf/q6iVTguxMj9uFQx5WxEo025oDdhTVyiMeRpuaM1E1suyszJVMKZmykMRJbac+6kQosu
F6lOq825O4W60E6W22ewc+Ra8FH4t4zakXlnF0v6LqWh9XOjNQz1qGL0lYChcU9utagFh+6C
n250fDwBm6UTPFEzxVwgOD4yPUwf8DL7hTXgDDifaNFjLoowR2d+SToNHTEQVBCuI4dl4F5/
dpQt18VWSvr2peNawf/e4NBvs+yDhE736Vg2fMlopelYMLaKG2CaK3ljLBue0Q8bOo4996ho
xyESAJBSvDHeKHxTMGFELXyHtYdr1xLUYA4Dcts8wO3XL8e7d7ZSpNEHQEe2kdgsXKuzWTT2
G7N36Jssw1Tfk+BxUkVkCAJ1ewHb3QbeWAKbfLgDF5ObG3sDpEEnSRmq8KhX3bbHMAy4Ji3H
grIRw4kNLYOfjvZgLIOebhaguYjyvzQyU98UgjwQgKTdXNa2rFoocrmQnGHqo8loLPY5H9We
EiLSl4renfUS+o+xAaOZPn18DoILUIIZUBjSxWdBLuzLC9gHCQOoHu8Hh52plK/2BrMCIElz
Om0CWLsosV2/LpyA0T1Pa73H+SJPzwfEouCJnQAme57g9Q31KHZEQsGIbD1Bqpx89wxv2LLM
hIidUsw1qNMhrh4oZkLQNhWv2GPtIcY2vnIoQrkZOjYNxh8IqQeX0+TQxKD9wpILsTCtZJZJ
Cd4E5d5AI+CmOZLIMOEYHBH3NG4ILGVZRHn4DR0lMGwM5z4sw5k8jFovoDqtazUdXGGhuCc5
AXi86LEXya7D3UZDdyZU8DK7e3r4cnw8fJ01iYmUdu4K8zAPxu1UPd0+fz+cfDUKppa8MGtI
7eARIyrxA8lQrxOxyn3lDC/PqSgVyRzXG2ayRUriE+x/a4pwSKd6tAIPt6e73ycEX4B/jLnb
xmrTEqqZqG0/5qpdzUmWURQIsL/2ody82oxvakT+33/D/MUIaxQzR8Olz374SSbpp75hHmzY
qMxNRXq7oiFE3+9hUGa6sgsV/w00YDwEs7eHzFiYMn1dcsXgmG/ow42c59MbfXUxpxL0QMrA
IHLCd4by4WVnXdopMk5iSHRsn8Pfz2HIABZwmQz1AsXEtoQC/Ln4/6rAwq8CC3qBF/QC9+u2
GJ2AptCa2MIn2EU9ZdwPWKcOeY4YxqJfTMp+4RPkgpCkLeco9DgcuDdDj1IpT4IdYDU6VZEV
9HvaZO7pIVAiWnoTK4wH7MbJNwnLqk9n83P6HXzEw8xjaZIkpJ+tipx+xMsKltB5JzvPG/CE
5Z6XW/gemh7WIpHbnHlQPOcc5/qBtER4bDT5lWbPXL8eXg/Hx+/vm+ugwbV2w1+FAS26lr4q
6Dl09Fh73io3DLnyfB+gZTBof3oQypP62dJ1PD1IHU+3X/BrfyjLMAS0f9vSl2+NMMJHbrT6
tCzwl9P7pWtE0YkfnSSv3xR2uJJrTzp7w3H9hqxCcPmmhRVf/y2mabVaTQs8F9OzaFyg6TYS
1yWrt8f97cvL8dvxbuxdgYs4CoVCESZjCP8eQI4iFFnEPd+ZaHiMK0u/LGtZYtqet2TfQ/yu
B73xh6NbBjp20o0AzNMkwzg5fCyu3L+0bR9knraJ+5oz1PXeeYczAaxezN0WG2LoCRlZLBl+
IeItpikZNywp93zQxOLBvCvPDFEEzH12YYLhAEEM2PYPEVmWzOfWNQypUFO2ihmkM91E5vm2
TDdMfOEwyaHFxHIYhnXwZiOhLv3mEhkQHEwyTGmiEUTsiS3VFkyYLK0ebIRU9mmUaczRl/hi
zcklAnDETJoPOQSZ82yjtwKUhaRvND5+KrwGzsQrhtcFHUOae+5dVnrihDGjiTg9YORILhDv
1+EumkubJ87N8wbm2ScN3QTmfOeZxVMH7jzXu5Xa4QPnfeWmfQfXzt0O5nP/5qqbff87Ox1e
TgR+yteF761VVjvoJlmWxLMp+EQmMbxJCLv743CaqduvxydMQzw93T3dv9j9MR/KDH1oUUW0
eAN6WzFwGHbKh+Tjah1S78LxrlaVjrOzFfgM1Q4/bjHL1E3UN0XoclspGvES0e25Y/kSU2Te
iKaD1/O9BJqKqHU8kfgGfctUBhCAimFZ3PUliPv2ySIH5TL2PClqmcwXZzCjQfFlRG3/jjOE
5Rg/9u3IKA8nZU0EhkA0mbKwldOgxKQS2V+86QgqxOw6XTgJthS1WjnDIFk2KzLDw2LtvhYw
2WfDdfXu4fj4cno+3Fe/n94Rfadcr6Y6TLib/dsRppbQbl23r/59j/7dFqFKRr1l6bgAieBS
rMy3N8zDIOsZ/VZAKe1fx2vhSZJFc/LZ830EJjyvyHi+qgZPia2oh+ejclvv7Vaki6r9KIgz
MNh2ng+apWxvcrsbjl4N6m9j1Fa3tYHR4c/j3WEWPR//rFMX+6fox7umeCaHaThl/YRkxZPc
jpw4xZVJA3n3/uXL8fH970+nH/ev3y1Fg9EVaR5TxgJWMotYIjPnSVLddixUanJOzYtNKydw
Ww2/FNCximz08RnY+Ip1HM5L966l+l1eM5mYJQlmvRPDxZc2W5OibOW7WfNE5Y2U2JDwuiHz
jXIzPsxHfPbQ80ZoScOD7tV1XjZPIylhgo10vqBS/67E3LJY5uNTKxBEhC9ZYxczxTwL+fiB
bZd6+dVokHNsBipMdRFUS6ED/MYFZaIlKHzzfqNbYhkSL5vSggbOMqbWAjPRUvyoWfMUy+RI
N+a/DwXVRUT9JtncgSlN/nlWJgn+oI/3hikETRi/Vx4wJU46sF1qPvJiXnRcfSIaV/u8kMkg
l3fEFqmAllg3k4DCbS1VsXQ8OChsxnW+oGjG3p4vLj5dWqYwwm94AFwLow09IHwMJjeYzOh5
iNx2sZqe0GDC9fdQjy93lG5qnsGG0vg9j4tkczb3jCz6MP+wq6Lc814cdnm6x6xkGgWG+vPF
XF+enZNk2FCJ1KXCjyeq0b7tx5BH+jOcbcyXrqX/j7Ira24bV9Z/RY8zVSd3RK3UwzxAJCUx
JkiGoDa/qBTbmbjGsVO2U3Pm359ucAPIbtL3ITMW+iN2NBpAL9FkNR7TnjgLIuNGs+qDHEBz
xvFNhVnvnKU7DFn2Q3RbVmN6C95JbzGd00d8XzkLlyatZTp258jJSPIeeE9xerpslFjNuEbA
9KV38kmbRxQ62gF6dBu9/fr58+X13ZxZBQUmNeOqqKRHwVYweqIlAkSVhbukDx4lZDX1TotO
3fKH/17fRiHKdb9+aBvSt+/X14f70fvr9fkN6zt6Qh/B97A2Hn/in9zKaPeqxgl8BrqOtGvZ
b4+vP/6BvEf3L/88P71cq8dn6/SE7yoCt/M06mQWPr8/PI1k6OlNpBA0KvFDeSBddZMPwPi6
qU1Gu5e3d5boob49UQyLf4ETIfCOt5fXkXq/vj8YitKj37xEyd/bUhPWr86uGTFvx5ymT5E2
KWOJhdCCdpgsJAgoIb2wEfTt5ym/u30rT4UljzQmdDUdgIjqTmYmmQh9dKdD2g3gB4YmK35e
uLtsZhimlfck9GLUZX7pUWnXCC0pbOpXeN2Msv7aY+DoN5jhf/9n9H79+fCfked/giVjmH9U
24ay3WLssiKVcR9RkhNFOk6q88y6m6fKUK3RN2WdurAtWQWPGlXddPgbxWNbRNKUKNluuaOU
BigPr77Qnx89EfKKSby1JoFKw2LQO2VuvN7ZALsQ/pf+VsGxufNxFwJnKcWonhaYLB3KBsRz
7ddrGFHa6/BAn5ZTNC1RvnaPEQra8rhwt2QJP3Exmr4gVf5KW3lUmr8EWWbOH4W0VJ80SmW1
5/fXlyc0Pxv98/j+HbJ6/qQ2m9Hz9R0Y0ugRvQh8u97ZDB8zETsPFlQk8k2SUXdNiIGM6rUG
ed61C7v79fb+8mPko9NAoyAjh7UsWEGRB95BkhlpWMVO0w/CwuTTy/PTv22o2dJUd1dnbK2z
7rfr09PX693foz9GTw9/Xe/+Hd3X7L06ivjdxW2mycIPix/kgf2WAAS0aRPUtAAastVxo9FQ
pjjdlC5oNl9YaY0BhpmquenZ1GVZdzxDtk8RsnJf0G2zb9krAZJm2SaCV8UEoj7YcEQVi1Tt
ODlcXvIdnJlgR4CDcpjEHAfEUlhfmEAEQYU6nUv9dGOuPEhCHRS8Gyj8Iv8wKDgiVsJtkCXt
vqpGiO+qSNDyIRCLKxaOuolEy0TIpKLfDcZ8GvuZf/co26wtMhltlEpTkHaKFOTlBYX9hlje
TjeTMol9dgDxxEWLxF/2IgpbXqYauadHSyEPGNlfCo99xwpTlnQ4cRTIUAWUJQhUwyv8R1td
Yz+c6GePRLtCi/MM/rBvaPI94x1tH18Oup+1N0TGNOPAHb7jiHO7JrK2hk/BbPFStDlqNOyz
KQtdQ144NZyCWlS28FpOHJaKW8tHOOI8fv2FwVQUbAl330fi9e774/vD3fsvPJR0iy71mC7y
4LrB4sTFn2ijSg+7pBsl6DiU0FvWjIWod5l6iW3VWVgCT735kj4eNgCXjqtSHqdyxb2PliUL
6RMFx9JrTU7iy5ait0HZAxMkVadxegkf7whbrwHUrZ+R4zpLhN/qo/WM7pq1J/Gyk2N7K84L
r9/6pluL4Nb2vWmQNvvPYa72RFdu5OGz43IGhOXn+EgVkRmjCfnpRJKkyEAKtV5J5UH6XKwX
XNwoW/XXBJ1721Z1N8p1Z/SlCpLmzkWSnlSMTGMB81CGZCvgzyyJExmQVHe6GhOdKk7cAIuT
6y5XtIpM+XHKahzCGiXdYBkVwu0D72zJ2mYw7+D8QdNQGyAjSUpItbc9WKnTdh20bzqJL4sw
Cc1n2xCTBj6Sylq5Snorh+ZwZY9phLdi4tRAdivHGZjhKtdu461yc4luSYYbeY6TVJ3pbj2Y
DhSM9GN4G9t2WUXK5Th3GAZQA6ZkEAUj81OY0QwbCZOUtNrfnY3ADjIMR5BSXacQO5CAiRbn
OFt3TBCu3B1PTzwZBHmOVjIOlu4LEL/wNp6hf8HFzFIjVBtgaF4I7J9v0wFFRji/cnTc0mAY
Qk+xEJyNLLHaRniAJ5e4j/fQ3WUPPfTSaM9XLgtwW75h6YUfCcGPjMoDZ3yiX3QiFcJacsaO
w3dAwd35gU/dqTtz++mLZW/2Ce6RLGITnoKeiQmb12Ud5mvBvfJrgCfRNQPwDppnpYxb0yik
DIbw5l8LcvrRteXucQ3iSs6/GNyIIycPIzlFO+g9fQZCepZHrsO8qDR0musiHUS0pcvIpkiH
f9xOh+Qw3dG89xiZMYLwVy3Z+RLmL0PTfhwM/rTrOccDdUXf6moKmqrTDERk0cph3o/g08UN
5wJuPp/Qj1/wlTOm63L04uniRO1sdsOlLTHpBKas5cKbj0/Y/wO50iIv3QRI73ko0g/s3GpB
4qZFJGrjhcqzNm8RZsnFo3Y687OWXNsmZSq0Og6PdEyMETg8SeY6IZ3P+Gd0s0hCYI7QfU/O
XBlXRH1rhOofNE86hpswGJokMoAjarF2mi9hNowd6rBoflnEIrQeVvLJiRRRrM+Kvcb+DviJ
uyQ+BAouLVtJS8NXE87lOlBhqxysvX7mab6CTWpFyormR8p26H10JoPNza1ijpEzmdPv6Uhi
eCaQOHZ6jJjbKrMOt2dfdDaQWx9qT1cFSY6T0er6pUSZiTPj4qcEHKPpfNynhHjZHVUozevc
asvL0EOAbkHnziR41o7Fjo+oCfdb18nS76P3F0A/jN6/VyhCiD1yt2LKZ3RyD7JTlfD55693
9uExjNO95bwBflbqhlbaZoMOmm2t14KCl2UtNZ6CoLRvyBvJsKQCJAU6IGyDdM33bw+vTxg7
on7neGtV/CKTvQrIwivKJVWC9D/UgimQ7IL4cvoTQwn1Y85/Lhduu7zPybmlEm6RgwNZy+Cw
Jix0iiHraAtaX94EZx3fzLpqKNNAzkjnc5eOv9QCrYgqN5D8Zk2X8AUkZUaMMDATZzGAiW5u
GAWqGpJ7YjFz6CsJE+TOnIEWR9KdMlKMhZkOYGC5Lqdz+uKwATF8pwGkGfCvfkwcHHPmXrjG
oCEFcteB4lSeHMWReexoUPt4cEBO+Q2p1GasFuOZDn/CIpwQSRcRmVHwmvT12aeSo2Qbwv/T
lCKqcyxSPNtSRO+c2v5CGpK2mdaRJizZoqYHGIU6YB5rjOIDlNVCWko0Skv23u6GDGLXgDYY
/wnL7NZIBVkoODfDCBBpGgW6lB4QHAHnK+ZqvEB4Z5EyQauTwpc17NucNlgBOSiQb0RfJvWQ
DeTU4Gi5v+bA6IHJEtmqtIuIBcwesowGM6UnfgPwaeWgGuAl64xucA3Zbib0YalBZIxPPQtx
YezLGtA+jKJAMm+5NUyfIziTuhqlQj84ooUn/e5X43Lp0wPZlKf9bfdjjhgGglHErkFSbOEw
wkhITcXx2TjJ6GdJG7Xm/Hc3MPT9PtgFx9CHH/2g210Q7/YDU0UokEzpDaLGoNixH5oKp5Rx
SobLRntysHhfkaLFXOgWTzBu8QxUmMJRaQi1zT3G21yD2Yn4yF1eGbCbdS7oIS1BBZuEiQQH
W8qXQNl0ZJOFUNfsDEYiajpgRJqWg0gTIfylu6QlAQuGVxoXeaKXmYlc7yfO2KEFEBPnnfNc
pR0lgB7s7GNgH5ltxoyUgdsJmapd+IEcgyCn+aYF2ooIbYn4/c1El++Fg7gwCqE76TOpidvu
49sPNIRjNzZouO/0vLwc3TFzsu1iuQ3SRIJY6jjuB7IE0bQd6ZrGSeU4tJRgwYJoIxS6JfwA
lhdNrHGLgxPzEGvldrN06PtdaxUHsURziuGh89Ev2fw0pg8bJlT/naHty8egsHkO1zM8eSG9
u1gTws/1I8pHpoS+gk8khu9kLP87NQ3h1DbMfnLl6bU6PEaAnIzHwzOjwC0HcSp3JoyLAgt2
chfzD5SaqsV8vBzmEFmykwVzph1OFWef0H4aLlJhj3BmdAkFYC0F945RXhNMT2MoPOfOgmXp
Es7AvfnIdD8d9yJEHl4ylBoDxndQdfkAIlNcIvuAp/wzvTtWd0fHIJOcp+4Ccw4Eq8NeIDzp
jPtK2ev/9QAwPMY6ZwK9lDX1Ni6nTVQN8yma9o5zKBXkQ+9aVUvElOPMZR5+ACczH5/jfBBZ
GT08DfWzw2SxmMNOnbKOzk3ksheZybArQejrqt319V6bp4R/JKO2TjvyiEa4IkwGWwj98xK6
49mknQj/bUWh1slRuC6uF+qqFumcc7CCWip4wZc9IKBKTs+2zCbz2Dz2PIPcChmQFk/e9+vr
9Q49wDXmdBU3yg0vhAfTxL7QaSyc8Ub6DVyZyApApdXxFUrK7kiim2QMPmHHOkY3/yv3kubn
VpC8Q5qrxtNtqLXvOfu74v1NZ0Jw11KcNzT4LdW5y86PGPdEl62in53K4OW0VTfU3QpwCL9v
ioRCp/7h9fH61FVZL6sZiCw6e1Zsn4LgTuZjMtGIFqp9SVsDaOI6Y2Nl0jIAMr/r6VUNiLPL
XmS5MuKam+QM457JoMTMKAiGvoh9My6uSZUiRg8lWc40TFtE25Fn7P7JtYdCjp4ptukbxdii
mNnznKIuIZ+4thpi4T/l5fkT0iFFzwmtjEvYK5ZZYf9FnChWYsJ0Mrnchq3rKhtjuxoxEo0Z
0s5XeV7M6L7UCGcRqiXzhleC1p5cTPshJW/9nIstNvgD0EFYRq/vkgxjfInSoUzkIVjv+aLC
VIaXIlo9ZToCLLAI0We9uFeJRcCXMJGMg7tsulrMOrOntJK5I5h+U/lz7GlfR8y+jO/O6Gdp
xskNDWDGCBZp5dCGrro4Ei4VGkbqwb+UeHeE40n3udH0hAA/LvpFwY4GiMldL7U6FZgE53cJ
6XSgEaSUjiXQYMguCIPOrBsPHVjpWpxB89emBU2jdGz20Vd0x1DsAKPffry8vT/9O3r48fXh
/v7hfvRHifoE7OHu++PP380RxXL9AAMzaY8ZlD2YhQ0lfSGGtIR/+UFy6onh/NMTKvXSVzRI
V6HMAyZUO5BPGD+2yxmD/8KEfgaWCJg/lMTOvN5ff+pZ3n3q1n0SJviqsOfCwk9q/xIg83En
b0RlyTrJN/vb2wuce5mwDQDLRaIuwYHvmDyMz+0nB13p5P07NKNpmDEX2o1S+Z6+qdTECIRg
llq4K2Ev7RoITuIByJrRo1OMvbMCZkgSdirssrFUdZd6anudgp99IQLyFBFkzndPj4V5fXdX
xUyBOaKvmhvNgMnMDVSEMR2GQNvUltrrmvyF1ovX95fXDl9AL9V3Ty93fxP9AE1z5q6L0Vz1
45SpIFKoNY9QySHmIjEYmiLX+3sdVBNWlS7t7f8sdRFKjaUIYIZuuSIr8IOZ3jMwKaobt71V
NrwfatlDXoscdnfIXk04txYWhL65tCCMd4oSotb0LK/o6y+TJWeNVGHwFnXJbZUtEF0b3Ka2
AerLndwV4zKkwkSpu5zQl14VBCo9c+Z0pSsMsKHpjM6mqvJW7LfBJcq9yWpGd3QxJWA7YZRe
C7o4UGeJ3VHawT51wuUQ0o9HBbVkcLuwq/sTF6bUBFOtvZz4yxlzOW1BaJ2QBiKdMaOFYWNo
FyE2hr43tjH0RZWFmQ7WZzVhJmiDyaHtH8EMlQWYBXdHYmCGfNJozEAfKm+5GBqL/JT2I3y1
GPDEg25uBorZLB13PKdFBxPjTjaME4gaNJ8u58zeW2K20dxxmWsKAzMZD2GWizHjTqFB9A/l
LtwtnGl/94W5S3OaCvDZYxhjBQBGkjmTgVHSNvxb7qRcYjQ3659VGrMaKCv3gMX2TwnETJzB
smaTSX/jNWa4zrMJozpnY/rrjNvUYrzoL0yDnH62pDGLflaKmFX/zEBnS4vpYFGLxcAE0pgB
X1oaM1yfqbMcmBzSS6dDW0QkF/Q+3wCWg4CBOSGX/Y0BQP8ARXLAtxjqPg4Bhio5wBsiObQU
JWcn2QCGKrmaT6b9koHGMGKQjelvb+q5y+nAQkXMjJHxKkycw2kTbTRClTOKTzXUy2El9ncB
YpYD8wkwIJT39zViVszbbdO8jTtfMRKlZM+d5ddqlw8sLUB4Azu+DJzltL+DA+k5M0YWNzAT
ZxizOHIGCXWVpfJmS/kx0MB0L2Dr6QAnU95uvjidCEMeGjowHzVm2i/OKikXA1uL8D1n4vru
oBCunPHA1goYOP0N5AOD4w5MpzAWE+ax2ISwF9ylM0ePeQquATvpDWxQuUydgfWnIf0TEiCc
60sTMtArh9yZDJwEju4UTuj0cc7ErD6CYTyBWpj+dmtI/5QBSLR050wIARu14Jy5NShYM0zI
FhsU7ChnuZq7C8OYr0zonpwrAnoAQm1GjBRO2sRXwMoX+TZBh3pBejmGKqByNIEbEWbFqxt9
s0N8ol00a1XZD39SXhlEUeK1HbV1vuNrRQB724kAtIG+sIbQJvKDzfr/NieQ+6gTr7bEHDFE
im8HVazS+AvfGhEnR3FOGI2WGqXOatO9UT1i9MT7l7+65kXNdE42eZ0NWUZx5d+PuQ3DDFU8
ekGlN5t+kH/sp6OkPz0NVCeM/TNLk9vU91CxrtNde7X+9PX69nDfdBw6N7X6CzCpRxVe9Sfa
sidKhWv9LluoELw8P969jdTj0+Pdy/Nofb37++fTteUjljR2WHtSdLJbv75c7+9efozefj7c
YWynkZBrYbkJ92TXHZ/89fT++O3X8x1eKvd405Abn5+WSBRqumT2j1SGXmFrxhz48XttkDJm
Nl1dwCmdjHmdR12IL1bjKZ8FkucT3tSkgtCbSkVmLlBqMr1rlWROy0+To5jPGqTX6alH5xNk
5EuKQbr44m8CmUb0totk103heMhXr6DzfaPpC0bVWjdBnJzZnDnDloDlcsFs+zXAZWz4S4C7
YlRIazpzkVvTGUG7odMyqKbnC05O1+Qg3kycteTn3yFM0QVpy0OpBcmCnFYgRCKcxeYwBfke
yvL5uJesOr4VbIA3z+fM4VPT43m+YKR9pKvA62ckKpwtF6cBjJwzEq+m3pxdmGj8WsITFUkU
69N8PB4o+6w85nyF5DyEQ8h0Oj+hOrNgbKEQGKXTVc9Mxmchxn5Xj7OIJON0ARWanTHzXNSr
7azrrwEuffBrAMwdTg2YOPwqKAF84zTAXQxUcuX0s3IAATtjXlLyYzQbT3uGGgCL8WxgLqAr
hOW0HxPJ6bxnweWSczeHe14W3iax6G3mUbqzHq4N5KnDbxsVZD4egqxW9Hk3C7Yo5jKysPba
UcWE6kgf29frz+8oBXXezP3MdnqbyYufXsT+RKkAGaAbqTpxcqr0zZokbdZo2V8L6+1iMTrN
BVrh1/FrOs3Annt4vnu5f3gdvbyOvj88/YS/UOvHkqEwN61x5B+Wc0ZWqjDebjlmjFAqiAoj
Z0GPSQWJT+klB6ljRegtCi8d/SZ+YTA27yWtnO//3ok7bWWKTtEEE1YZ6Ycto/2GxL1PhlwC
ShETuRJl/cc3kIT/1dEBtNMHEG4f7/96qD3/b16vPx5GX399+wbd7Le1pDdrcwjrsEQ4hETx
MCk86eNTUzMrIC1O8nBjqUtAos+wcyCtkwSd2ylyrhtFwb9NGEWZFeS6JHhJeoaaig4hREvX
dRTmrfogLUMHF+EpiPDW6tIO79lgMcIRWTISyJKRwJW8AY4XbuPSb2xPiYmtA4TJh63gInYB
WQoPg+DRWxt2tPBuOrpfxufwbbnKldWaPIx0Q/JCc707j75XSn/E6Qe+3+PgcpXqd8CAjXZ8
Lb6zdJBI9huW3Fo5Jilcy8v2lM/mzB4AkEOY5XvGpBK7rPIfynY5OtJSu4BRCgGE2CeXG4cL
OIPtC+HoQfo/r4bzEnm+ETuw/hiTdfTLMuhWbx4msBn9hl7G8LI8gtVEOL2sZg7s6Uzo2AYJ
Z1nXZd58WihGKcJotpxy76EG6ABH52XEBKKqYWsfBD9a7oJFp3JBMoedrx3LVoEN3l6edMga
zYKLtdDdniE7Ss8ckuGv4vpIeeg6ux3Erbna2GJskqPW5SxzojYHHfjJa9s8WMnw/2gvY/Wn
O6bpWXJUf07mNTPIhAyKwGvdnAliZXqQZsANM3tPINBZknOXflGytVzA4W/UcgCpRsIKJPvJ
wEDv2k5wuhAv2ueTyaxpj6ZhX3coKtnHfusnhltpWxZY6RgYEBZZaFjGKCuX2C/04O2k1LM/
gFPglz1e+2Wd5GLs7GQo/X+NXVlz27iy/iuqPM1U3Zyx5CXyvZUHkIQkxNzMRZb9onIcxVFN
bKUkuU7y7283wAUguyk/2UJ/xI5GA+gFxTM3MYJNL0NSryg2UUdDVzFBJOrcVLGfHRrI43VT
pOIk69AwHKZxBGfZ0cQNa1snYYAhhjpVaCLsWIl1LBIkztyALg5VxQWzxLCqrF4nUjNxF6lA
YVtZTJKG52hhdwp0cRKUe+JODiJglMdnN+Muxm5P38moTmbDFSBVsEH8dE+ChKgYvy56RItU
MJGe9TQxZj3jKza0G+aRlp03OmM3GXzUErhlQAbgBWrcovfBMPFNqL+rC3fmp70OwCW+EOGE
6bYy97pfaLcdJefsvEaUYsy9LVYIXyjBjygirmacj4gasVAz7vEFIZ4fTDjbljqLNGEeFFs6
E9awRhRJ3LPI7IGWcCQXlI1JxUl8JXordZXqOOZsvmmgx8FnnhZxdBPG+EkzZ9yYCJtcOO70
9m1IdFR04VTbaE4XmYznpDtbgAGncPwyLsjDFObXyljmmQOfIx5/6ur0zCURLy66fq50qp+R
pjyahg6ueh9gIuM7QdNLXFFMjp4Mb1Tc6xlZJOl6Rr3lItlfyCyzdiqTpuDXfTcn2DpzMVA5
YPGBQpN6FuHrixSuJl3fZpgIQzZP4qzzQNqmdhrmlCbxtmSAHEo/oc/5hpwwFZUP0Mhu58xl
5CnmvlvTZ4zlEhIXScg5HtLfFlfTc77foTY9byQ2+b43zUofXdAxTzBAvxNh4e41dm3us94V
E6ajT3ea+yG1uFPxgjxkmybEORxpi36uoc/bZWi6jJMlN1LYSmpd1unr4AufcY2BHynVFw1A
BzqzRV2VlZEXylQEE24CImp+fXFGL0yk3sFRNcw7mWPFIgFDpx3KMa3W7tfx9OIuJRDOgUX2
Z662bB+aQHGRqXn3K9hiJGVyrhmBiFF7IEwyS6i2EolGUb5tHHIhwvt41fsMGBWcrXmWhE4P
syTmnEEYtsXGeUcyyK2+oLc9JANH5DuijehhJ3ZYK/4e4lN5KmXAeg7RiAKnCuxXZDBvjShj
jEjQ7b7MNY6zFzk6ixG5Kwc0ifx2ksPhsviS3HdLs9OHGlsodjEDR8ql7O386JR7TkWzMcSs
zItIQA9ZByM7lZiL2lMVzxuVYp3FIH2lYCYz1cHIblXPVKl1ClENdCMNC5l+pNN9rdW11ouy
b9iJb5+k6GTk1MCdkamdUCGMm9/WmNjJrKmGtkkmhSjMJsEwkXhbGcrqjtUtpr0osxKN5qeb
pt2tLES+XvhuTTuwOAYe4ku8klm3weOa0N6bn6iasns76P6pXFi7fVMrfeHNq3L9j2uyc2Ym
R0Y3vKBPqxVtfbdQ6GSViRqrTyxhqrrGrha5o2qHSXe68zwxoycDhjluA35S6lL6+6tPq7Mz
7Ga2Zisc1A7AIsuK3K2eTs/wfQHm67rgW66BBQZ8u8tBOOUrUpc0bBiuu3yF/q4W6WC7VJ6O
x1erk5jzq8kgZgYDDKUNdFHCdFHy7gbl4RQdug/UIpuKq6vL60+DICxLm77iewM5bSrlOv/n
44G0DDe+NSnuq0+rmfbK2pupAd+yIuoHGo6B3f7vSLe7SDK0pfq2+bV5/XYY7V5NFOKvb8dR
G6B59PL4p35ke/x52I2+bkavm823zbf/G6EFsp3TYvPz1+j7bj962e0x4u33ncsPKly3CVXy
wMWUjapiMJzEBaIQM8YhqI2bwT7MbVE2TuXBhLlwsGHwPyPg2Kg8CDJG4bwLY1TPbNiXMuID
tNpAEYoyoJ+sbFgSDziLtoE3IotOZ1edRTEMsX96PGQMnehdTQZi+JSir8KKC0y9PD5jPAXC
YYrm84HPKbNpMkr6AzNLDThW1d9rLhAwTmn0hnfHqOJVRD4qEZpDo5O3QWb6yX1/arqFiwWq
e73nWrX5zN3kme9lpBjlx4rKmD9rXheURUmfFUzVlrnk+UGmEu6BU8dxkvOkYA+7GjHAzLkH
Pz0W1XT27z/5jGangWmlb37Egt6x0936ikDxzmV1/+H9VgAjz0Ur1r2ocviznPNTh9H/1BtI
hs7ZlsrLWG0e3ZRkyDm3zkgOiGdyketQwLB3ztSqKAfWmMrxVXNGe+ZCwD18zU8p+aB7dsXP
2EUOAin8c37JmNjoHkPPS9DpcOAZbJi/EEneCQfdLK/0x5/D9unx5yh8/EO7v9G7PhfVLkmN
AOlLRb9ENCIWc1mvvW+LYD4QzAxmF9qZMGvwjtEI5VRZZaQdjxPiDZ4w3PAy+Ms83Tu3QU0q
xtnOF71+xWVLdKT+Tivd0fyipnMWxpqe+uL6kvExazJA7U1a+aqiX14yFlctnZ50DZ3htRV9
yqnA1nROQ6FtIKMj2gCuGF16DfCCCWc8qukYtOWS0UYwgNC/vB4zOjHNKF7+Hhh4LX9+/bl9
/fev8d96oWVzb1Tx87dX1Mcj3h9Gf7W3H3/3po6HC77vzAwzLfbb52fnAcM0BFbNvPMoaRPW
vGMiBwaSGCvYOcCFFFnhSUb0dKCkuhQN9VNardwB1af8pB/xavvriB6NDqOj6aZ2DOLN8fv2
J/r9etLKhaO/sDePj/vnzbE/AE2voTNTdMf0jqoL6GB60xO+L9FSRoWquCfYUVb4axNX1kro
MSNMXPhFkpPOSZEKlAKOoW4+VWKtkfRhf3w6++Dm2jsH6f7IMHojEfMKv4CT4cyYdrmF6XRU
FiCSO6Gn7PR1qaTWfiW7T1cxW/a2vuZ6C2tKcOH6O+F5lw8ypzldC1pNGd2xGhLksLfRzMSG
MDa5FuTqE82zagiakl0zomaNyfJL//xEPioPx5MzWsfdxTDeQlzQ5XDbVwgZRGgjfWbHcTCc
AZMDeg+GMRJpOvpiXDDeKGqId3vOhMqpETls89eMy5saM4vOOYc2zYDC/GNcJVmQS8Y9mZ0L
Y1tUQ2R0fsYY3je5LAFyzRwPW9B06sqs5rE9VZ0FaS94VD1HZYK0UfdDPHqee8dCDvJzzum+
NeqTsds64xrv5+MRNuoXvmr4tR8lPZZbrdkJY45iQTh9ehtyOTwhkTlML9czEamQiT7dIj8x
0mMLmVwwbjOauVvcjD8VYphFRBfT4kTrEXI+PO0QwkSrayB5dDU50Sjv9oIT+ZqJmV76jFxa
Q3B+9+8udq8fUQBxp0ijyJJvXg8g6p2Yo9bTTtFRiamQQSTa143m+zaV2Y4B0LczgMS1jOfG
cqDJSwfsxfO+YGwzbjGYywIB62ge0cJNi6HacIdFGyu6zy+dVEhoauwbt5ltjQV6El4Xq8pP
eNsO3N3t+KaiXA1eNTBKY6hoXmvo9fpwud0ftztq+PAzlcBZknC6GW2f9rvD7vtxtPjza7P/
uBw9v20OR9LBdiHmKqbMr1FhrnkaWBMTYJ6EwUwRZ8zGE3D+a/uqvXt2JqevE/Pd296xm67y
9cObPAPOO51cnrcdDqlyWRCpXhg0qe1Y6MBRqWL0xxbmdAHs8wQgKkrG1UiNKCL6ACAr/ViM
fkaf9oUKvYT0vJxEUWm9VhqrL3Siun0aaeIofYRTgHaFmrseVbPNy+64+bXfPZFOIAupH18i
YDlZ0n/6yH69HJ67o4V6dH/lxntz8jry0S9zazBPOUIo45Va55lg/O4l6CKYJKV6os0yRttV
rgqfsyKVUZLRC08xCy+9ox6SBEz2OT65itU6zj6Pm0GBKXbdTjyV3ZoVAvzX4WQpnB1Zt8Ha
SSgqvReo5s8cb2fEmxRecuVvX413bLuvK8VB9hYM3eKio+rJNI701d1pVJl7jLtYP1rfoGUl
Irol1jnhhbIvUrtPIr+vMZDCKQ2km8dX4AAvu9ftcben2FNGvGOI12/73fabDQMJLUsYn6nx
knMunxeMD2u9GxV9xjZL58I19bOWXzt+6bzvMmK23b9onkisl8baDipKBXSebWGdm6F3voPl
MFnPqLM1UM4d1fgqAR1gqBUc78M+KZd+mSk7WApQLrq5XKDfF7Rk06X3sEwBF50C7CZcgDzg
Z/dp1/zDxfREjIr4xQucGDb4mwVDJSLPF/7CET4yqXKZAW1GL9ovPGnFk+azvDs47UIqBoqL
VTjw6WzS+7JtHNn5uInYgzhToVyjT20nGk2E8WEKYKFdeltyzgxUQ2/MP2sZqZugTIJ2HeRk
LQyByPW2TApL7NI/MYq8fmDQz/2oBG9nprUAKiCsqlgxvowMgpsqhlpk0sn7dhYV6yXlL9xQ
Jp2a+oU1FBhFYZZXK6ptu15P9GAnIBOCOLkm/BH5j08/3PfbWa5ndh8ZfMyS6J9gGWhG0vKR
elDy5Prq6sxZ6F+SUElLUeoBQG61y2BGVStI8n9movgnLujCgOYUFOXwhZOy7ELwd32B6oPs
kqJ+xMX5J4quEjR0hz3284ftYTedXl5/HH+w51kLLYsZfYiMi94KMzvWYfP2bTf6TjWrNUWy
piEk3XSfw20i+sSw54dOxNahupWCtdjLzl+oMMgktfpuZBY7tlDuVWcRpb2fFLswhJUoCqf0
RTmHJefp2pGdZv5wrAnj+2m+gle7MnL6KclEPJc8OxTBAG3G06RmVRx1wX8IJKMhyfDugbp6
A9XhSWEyZyg+iNAMKb8tRb5giMuBfSlSMQz6CeI6FgUcSAlL9XbcooEuTHnabby6GKRe8dRs
qNAU1WMYc6j7fMl9VnKTtg4s4c7bmjhzuRb+trm//n3e/e2uNZ12Ya8FTMnvBG11Z+BravPR
eo6xy38QjltLFSEuiMk2ViDkHiDyBnE3C0qncK5DwKUYtsnSjkWJofvTNM8qC9rf18JFQlcL
F46QWep3f6/n7gNTlcprxfkyXXAD7ytOAPNT9pskEDwz4iZSaE+UMK+3oM8f3o7fpx9sSr2/
rWF/c0bCpnE+e10Q48bYAU0ZDbIOiD4NdkDvKu4dFece4Dsg+ra0A3pPxZlHmQ6IvpXsgN7T
BVf0tXQHRN86O6Brxs2wC3rPAF8zLxQu6OIddZoyL4kIAgkS5bE1I3TZ2Yw5zcYuiuKFiBG5
r5S75urix91lVRP4PqgR/ESpEadbz0+RGsGPao3gF1GN4Ieq6YbTjWGCxDgQvjk3iZqu6fut
hkxfnCIZb+phs2dEjxrhy7BgLrRaCBwRy4y+AGxAWQLizqnC7jMVhieKmwt5EgJHSvp5tkYo
H3UamcusGhOXzN22032nGlWU2U3nBt9C4BGpvn6+2exfNz9HPx6f/t2+PrcnHxMPVmW3s1DM
8+6l9a/99vX4r34t/fayOTz3jWCMJwZ9VW6dCmWe4xIHyTiUS9n4Rv58YcnaKPNUXweSe3Sp
DWjoFyp/9/ILjnMfj9uXzQjO00//HnRdn0z63qpum6MOvoShF6l7t1h7nsZrBys2rXUbY+hR
mRdoCa3jmtVnU/SKor/8PDm7mNq3lJlKgaVFIMZG3LWyCHTGggl1U8Yg5aEXxshLQkZ81mrt
dzEZxNM02hZ4F1CkzPKmFZ3+yaWP10R48ovQwy+RZxdiei2J3XhrVclJht6OpbhBubOrdFXP
GjRURVnfjnZrJTZHfzMKn89+j932GSm4seDavOz2f0bB5uvb87OZ825n6ci9OXdrabJEoHZJ
wfd5mgA7ZW+pTDaJ9wV6izkJhqVXw5gIBohAR0akuSY6m67aH8kohD7u939NYacG5O7fwFGi
Y7tiiEvqncWQzLMNLCdlWw+3VdL54jXYLEzuiGlmkwf6L18Ah+pfVuHQjsLd079vv8zCXzy+
Prt6sXCMKdPKmRGjvV15OlqUMbBDkdPM/e522M92CszahwFcJwnptN6hr5ciLGECu0TkoUlZ
QHI78mjRxt5xGqobRVan6bniHLQ00gyyjAOz6gf6G6tyI2VKvyzX76KmEKMoig/CzVIb/XWo
Xo4P/zN6eTtufm/gn83x6T//+c/ffWacFcBRC7liPMlVUwAqg6M5ADmdyd2dAcGSSu5SUdD2
PwaLha0H1n4G87a+Z2fuhSAD7KWBQkSR4Pamo9GfqAsUgz6UgO+GM1Rd4C6joFCY6WhjwKvu
65mgt/6BQm8M1xqqFmeSWjFPdQqRDzFN/aagJGM3WwVRzGQAIqIS7q5oHsP9kuH+euiQTPZN
ijfQSEbWji8UJOxkH2MG7wOx44BUeTsUQLaa1rfVDpvxCs1VPFw9P2Dnw3d6RgCtun0tsyzJ
gL18MRs9Ca6u7QcxIchQsX/PeAjBvWJWxkaW0F2RdXaShjrPRLqgMbWcONPUbgZGyI189BgB
wpbvOJrQELzLh7VuMtfDnncQfvWhycW6cYcvcGkSXhxnvZE18/LtVQusxeZw7MzM8CZg3rS1
7RCupnXOeWu6gXntSZDhYTcp7vk559VrX7OSgbnp4fMZT9drA3ay9TAMBD6YkzzdsMCri4ax
0SitxZUJFVzxWelOWshVUEY0N9UAFMjjee0vlcfdALBIGI/iOgIwnl5o3xSa7qkiYi6DNT1b
iHyhY90QC8MrVQhbf+LnmeO6E1XocBvgeYKZKjcD80iHfkH3twN1TwcaRvmE7pTAH+lAZBwe
QNwyYSmznqFygW5VWVlYO3+4mQeO7zf8TZ+svJw5Y1cOkvGgSlsJ1BLJwDarX3TNUBEvkvnm
6W2/Pf7pn6qx7c7roXEvoQN+y3ucvswDVvUtSaxe/2Uw0LWVigfGlsu1uhOsFVcE6CAdKbNK
I2/Rm6yrdxnqw+bNZsV5v2qQXeGtZqBwzEYdHHwJW4sgyD5fXV6eX/UqAbwGXYdacnOHou8n
QBIQ0XswlUA/ZpGByoVnu1ztI/CiJEkHEGLpN0I3h9GCfSZvYSsomkr1e6+Gp0mo/PvAQ8ea
uT7MM56N2i8j1rdtDQF+ntwzDhZrjEih3yI25GOFuhekLjBuPPPu5GsS17max6JrY9tDofdB
Z7dWjJ2/ZI6/RvQhZpQlcnUwgfDfkdXnD4fNz+3r2+/maWkFcpiW3PJW9dlsiK46tEkDBuun
991UyKOblN52U8z+ioLOsiVprpHUJz1//+fXcTd6Qv8Xjdt/S/lXg+HcNHf8vTrJk366FAGZ
2Id64Y2v0oUtAXYp/Y9woyUT+9DM1qpq00hgc6/Zq7pVk3ZDqb7LqTldESMRiznRtiqdyg83
85MZ1gxI71V5L/v5bDyZOs6GK0JchnRivz+Qcd+WspREHfUf+ka8rmcf0unSsljADkZkTlrp
ibfjjw3I2U+Px823kXx9wmmLCp//3R5/jMThsHvaalLweHzsTV/fdt1c95EfUS1bwBYvJmfA
Se/H5645movM5a1a9nKV8LWKVeM8y9Oq9S+7b7bRRV2W5/e+911FnyaV2oKbIj3ikzCjL+Aq
cgqFD9FXzH1ERQaJ4y4jVGMXj4cfTWt7rYhIflkvXzT86LdjdaKiy06mVfCNZziM9Ts8888n
VCGawFcNyMX4LFCz/iSqOFGve4np01siwcXAOg8uiWzhYLUQMsS/QzlnUTBmYsxaCOZhv0VM
LunHzxZx7tpAdRbIQox7HQaJkC3RNCBcjulH35ovzDMuynDNstJOFmYSbn/9cA1a6v0oJ+oh
4tJTA6sNjiMXxGewnd91jW96s0xEMgwVLZY0mLwYnDUIoPznV+SAbNRM/x1c0AvxIAY5ei7C
XDCxDzvMczAbyTiqaehZypnLNxvEYBfCkYM0g8LXxf3mcOhEBGo6bhYKxq9jzVIfaCm4Ik8Z
w8Pma/oBvyUvCAOgx9dvu5dR/PbydbM3Nke9kEbNxM3V2k8z8oq/bmTm4YE9LnvrUlMYFmxo
YnhyaxDsXsOF98r9otBxt0QDnPSekYb0/cip8htgXslq7wJnzF1/F4ey68DWdUf1mlxiRNZC
+nzdQUqPMHKNuR5ZF/cpoS++2R/Rsgukm4N2FXLYPr8+Ht/21RN558rRqEauC3Rxaq4GMu5B
w1OxyO6Jay/zBLT9un/c/xntd2/H7avjv0GfKuzThqeKTOKZ03U13VzftHSiE2uTqViiFriy
tfMaaypfoRWeSPsklbh9D2coXxXUFQfQxlf2BPTXza7uZKCKcs1kcN6R2CGBvOd0AXAol979
lPjUUDjGoCEiu+P5EiI8RvMEqJ+IOoXKq+SgFwc7JbD6UE0FHDIEPbZ+EqWiAdE3zyIOkmi4
qx4w8IaKNRO21FYfEl2A6xkeUwNJpV+Q6asHTO7+Xq+mV700bS+X9rFKXF30EkUWUWnFooy8
HgHfofr5ev4Xu1+rVKaP2rat5w/KWgwWwQPChKSED47BdEtYPTD4hEm3ekLkeeIro50uskzY
oQREjotWRt0kHULGWcyY7ppz31rH1HmYOCcc/D00leKwspfosIr6ZcKqfe1YuHm00GM906YY
2CZnySZZwEzwIKC3G7RKhaMAFbEhQf/bcq7ywg6/MEvignx6gnTSyAzx09/TTg7T32NHxs7x
djtk+ETTCYDSp1einCr6mnqoXf//P6wiqY+rKgEA

--mP3DRpeJDSE+ciuQ--
