From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 24 Feb 2017 00:20:07 +0000
Subject: [sparc:master 7/9] arch/sparc/mm/tsb.c:155:3: error: implicit declaration of function '__flush_huge_
Message-Id: <201702240851.vBtmGSbs%fengguang.wu@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master
head:   cd429ce2d095041d249ec85feaed608bbf72154f
commit: dcd1912d21a02534d1f0a9005d5ba3283f164780 [7/9] sparc64: Add 64K page size support
config: sparc64-allnoconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout dcd1912d21a02534d1f0a9005d5ba3283f164780
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

   arch/sparc/mm/tsb.c: In function 'flush_tsb_user_page':
>> arch/sparc/mm/tsb.c:155:3: error: implicit declaration of function '__flush_huge_tsb_one_entry' [-Werror=implicit-function-declaration]
      __flush_huge_tsb_one_entry(base, vaddr, PAGE_SHIFT, nentries,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +/__flush_huge_tsb_one_entry +155 arch/sparc/mm/tsb.c

   149	
   150		if (hugepage_shift < HPAGE_SHIFT) {
   151			base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
   152			nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
   153			if (tlb_type == cheetah_plus || tlb_type == hypervisor)
   154				base = __pa(base);
 > 155			__flush_huge_tsb_one_entry(base, vaddr, PAGE_SHIFT, nentries,
   156						   hugepage_shift);
   157		}
   158	#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--J2SCkAp4GZ/dPZZf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICOl5r1gAAy5jb25maWcAjTxbc9s2s+/9FZz0PKQzp4lvcdM54wcQBEVUJMEAoGT7haPI
SqKJLfnTpV/z788uSEm8LJQ+pLW5i9ved7Hwr7/8GrD9bv0y2y3ns+fnH8HXxWqxme0WT8GX
5fPi/4JIBbmygYikfQfI6XK1/+f99nW2md/eBDfvLi/eXQTjxWa1eA74evVl+XUPo5fr1S+/
/sJVHstRdXsTSnv34/CrKZjm8OuvQfvD9VWw3Aar9S7YLnYd1Nub01j4NakiEde/3r2BXXyr
N/N+7hbfHrZWPS2+1J/edAYXWvFqzJUWlRX3tjc1s2V/sYxVLIp0ZfvnkCrLyioRaSF063SW
8bHVjIvKlEWhdGtEqvg4EsUQ4FZKZCh0zqxUeVUoY2SYihZKCQxwiKdvCZvAKsKWRQV7qHhR
AoJgJ4RciOgIElkIv8VSG1vxpMzHHryCjQSNBuftjUHqZKzAU1vRg5mRA6ciH9mkd9aGAgZ4
GZYjtyRLgTwntGJkGRAAhk9Eau5u6OElsDMU5jTsKBtVKo29e/P+efn5/cv6af+82L7/nzJn
mai0SAUz4v27g3yAqP4ajJzcP6P47V9PwhtqNRZ5BTwxWdFifg7cEPkE9oNLZSAY11cHINfA
voqrrJDAwjdvTqLefAPRM5aQd6AASydCG5CBzrg2AETBKmIwHJ2Vqa0SZSye8+7N29V6tfit
NY15MBNZ8Pbg09bcpjORKf0AegBinJB4ccLyKBUkrDQilSGxNyeptYahHMM+4DwpkNORXupP
wXb/eftju1u8nEg/ErnQklcArkyipi3qw5dCizhV0ypmxgolu/bFCMQ5fTtMxVEFQaJyaw6L
2+XLYrOl1k8eUSekimTHXOUKIdJHAwcmIYkcJSB8prIyA1a2cdxOQPne29n2e7CDLQWz1VOw
3c1222A2n6/3q91y9fW0Nyv5uFZ4zlWZW5mP2nucSG17YKTBYEnNy8AMTw74DxXA2lPCr5W4
B4JY8nCWmbFBJBKKg8FGpClqQKZyegothMN05pNECUuZRlUo8ytaiOW4/oGW8JFWZWFoWCL4
uFAyt8ghC+6BRDOAFzkFdHPRZxUpe6B3n45BSyfOeOiIUBPOK1WAdMhHsMBKo/jB/zKWc9Fm
RR/NwA8+pStldHnbUg7QPJsCI7konKdxtD7Baw63F8vApkhQbE0TZCRsBqyvGpWmkR5MbM5i
gL+T94ReHBHGMNI8ZDSw0MC3sUdgaFkIwQFUcenZTlxCbEBCRKF8h5SjnKVxRIs2nswDc+bI
AwuL+DxlEzDYJIRJRX+PJhKO3kxK0xO57XyJZ1ewZsi0ll2ZOBwHw4xIRL0wBUW5OlreA+Pw
I6xWTbKD+z8xlV9e3AwMVhNpFovNl/XmZbaaLwLx92IFVpKBveRoJ8Ga1+a0tUa9MHmYSVZD
K2coffKHjptZiAZoMTMpo9yeScuwE+mmKvSOr2Kwfxi1VBo8rKLZCnyzIqsiZlkF8YCMJXcR
o0cvVCxTsP0+46BqjI5x+avMigq2I2iJayIu34wuRq5YCsqAhpJzYUxPEsb9mK3+qoUlAXkm
h1+qKbM8idSoB3IhhjNpiVLjof+HGM557somECj3ZdTF+oWsg1Jq5hNt+rH7YV+GxaLiWXHP
k1EPZ8pAyCD6qur45BDmEUiNsP0rXAX+8ITf8xIuGQGqWsHBpfl4Bj9jKuToNq4DiTbYE0t4
KJ9j+IXqlJQjgXF9K31QUZlC+IMKL9LYOcreLOIepOfIm1PkdFwhYYYOS6VhYOwN8o84p4qi
Ck4BNppx26Ek0g8+m9IUIm8JREPTBtwfheSAQE/EoH8STxvHht7wpEmPOG04HI5yrpil1RgS
QJFWeko7Hx/yIfT3DwKywSZAA+y/WqOFXjOtjz4QQ+TlfaV05HLhOqHiavL759l28RR8r632
62b9Zflcx7HDBRG/MVlAO4/Dc4Q9aDPqK1eJQHkjdud8vEHPcnfZcl61FHoCNNXl0zHbAysK
cxUyr8ockbrpRQNHsW3g52Dk2KmWVvgGt4Hd0d10mFmVAV10Nm0LI/qVx66vdgwoNuv5Yrtd
b4Ldj9c64fiymO32m0XHgYLNpFnxWF1eXFBG5bG6+nDRUYfH6rqL2puFnuYOpunH3onG1IdA
11MDjhHtLgNlZ+lIAdGSbOgDkqmARMwOARAQyVAzoHSEIXyPyBl7aCIZXsVRx9IKptOHOBwQ
GKxEEG8W/9kvVvMfwXY+68s+mhHgzidPFHZdZdyndZBpC1TPOl8HoR74pDoPBoRK5KxbS+qC
G+txgkNOwQUc+L56VLmolfry+hjUnFv5NCtkLSWjID2T38wD6bwBNaZmAt+k4QcKNIH/oIE9
nrBTVOzg+LwfBrNdpet8BjMfIS1atR8w/KFStj5K1zI130FvY+VGkkXNFJxcYd3sIAFY3OrG
mbwf0R3iueTB9IuRpwzJZMSQQ1HIUSkD84XD724u/rxt591Dr01M1SkSjjtn56mAHJWBgtLB
c8bI74+FUrSZfwxLOvV4NHWmQMe7FAVAsERWWOBG3hGQw/eJSiGoYZpO2Rssz7EiZ53D3imc
hof7bbB+xUL4NnhbcBksdvN3v51KLAaClZZEw288YbojwWVepZAHeHJeLn3fKxjEZO4ddz4T
55xpmva4IQVREvjoLB6Wr8Q/i/l+N/v8vHA3B4FL0HYdVxKCXmQWgz+q+NGkWEecNjGar4Zr
6eFGHXKpkoY24zNpPNVPpUVUZpSVqPfVqQAKKtyoY2nM2P9ymukOHi3+XkKOGm2Wf9d56anW
vJw3nwNVy0mbUmWdk9a3C+SOIzGxWRHTXIaAM49YCiLvk2o3fSwhVADFr+tqdClkWqWKRZ5N
oC5OXU2LImBrr1jlj7SceA/jEMREeyKzGgHL5s00EFBlauKp0oGZTB6AcBNpFL3g0eeDLYNl
JfetCyGmAcUE0xeWcUxEUajoT47LHQZmlirwqbiVecQY7WZY9WwLF3yGc2lfDRHsNMZ6g21k
y+2c2gfwJHvAmJGuPeU8VabUeI2k/VQwmtHlCH5FbkYIPFmw3b++rje79nZqSPXnNb+/HQyz
i39m20CutrvN/sUVdbbfZhvIH3ab2WqLUwUQQS2CJzjr8hV/PCgUe94tNrMgLkYMjM/m5b8w
LHha/3f1vJ49BfX9zwFXrnaQi0Cc7FhXq+ABZriMic8TVRBfTxMl6+3OC+SzzRO1jBd//XoM
zM1utlsE2Ww1+7pAigRvuTLZb317gvs7TneiNU/oGiC/T11y5AWyuDyomSq8tR4ZiYOZM9zI
RvpaXD8G7kZinNhxbvgt6sYFDR1e97vhVKc8Py/KocAlQGPHc/leBTikm8HgLY4vkM4wGThG
9g61vdERywQp4xxEczYHsaO0zlpae8HU+Aq2ABr7YLgryPjRzkKgQNc/ikxW9dUcbfGS6bm6
ouXwrxs/1ey44iQXPPcvpqCjEgO7o3dl5GDNAkSOWLMohjEHfmsaFtbuEu8wqobaIpg/r+ff
+wCxcmEKxNN4XYmJL7j0qdJjDLFdsR4caFZg5XS3htUWwe4bJMhPT0t01LPnetbtu/b2RoVU
vcvPI2x66bn1mIKGsYknUnNQTIvokKaGY+6f0sKWTL03bYnQEEfTe20qq1TmYsJ2Z0Kt+evV
cr4NzPJ5OV+vgnA2//76PHOW+cR9QxXHQ0gLBtOFGzDY8/VLsH1dzJdfIEZiWcg6MSQnrEa2
f94tv+xXc+TPwXo8HY3kySvHkYtU6GsNADJI39IqTsU992jKCStJeUSrAeIk8vbm6hJyEknj
JBaru0bya+8UY0g9PGEZgjN7e/3nH16wyT5c0HLHwvsPFxfnCYE5gkd6EGxlxbLr6w/3lYVc
4gwZbOa5iNJiVKbMeuKzTESSHQpbA3aPNrPXbyh2hJmI9NCKMV4Eb9n+abkG73ose/02aFhy
yPFm9rIIPu+/fAHbHg1te0zreMj4OHW+BMSC2vnpxmnEXL8MbSlVmVORYwm6pxJI3lJpbSog
cgMCtSrSCB/0FeHHY3014R0PXJphwQq/uTDrqRtf4Pfi248ttogF6ewHOr2hcuFqYD/JY+Wq
cPB7LuTEU+4KwdlGI4+1Q3CZFtLrAMspzZcs8winyEy/lNjK8CDtERG9Un2rJUMJrHggWKVB
s8ETnNiAHzJ+eXP78fLjEMJTZjqXB/gx4VaBCnpmx1tAEIbuPM3HJp25e7PZzS/edGd1WdSA
6wAJlnhv+mXWE3UcI3Mb45y0EuOkejLoZzrGDjh3T5gwRvB8Rk/sGVU8z3ZYUejBevvgmRqQ
Er9H5vLq4+3ZIwDKh0vaXrZRPtDmuoVy+/FDFbNMerxyC/OPm6ufoFzddO/AByjGji//sOzj
WaTs5qP9yekR5fqDR9wOCB/+pGibmez26oZq3zxghJ9uPl5cUWN18YF7nNQBZXJ9cUVfHRww
Hh/yT93Cg5OY9ep3LMCflRdT5jeTrhrVVGU6llpQWza5J147numP6+6R6gxFRoFZrDCp6+6o
XWogKhF1FSljYRkf6omd0Ooh5xXemNGWqryPpCl8tYTS45rdjW+d/w33MlluYBfUAXCYVGBw
u9M25Yn5Zr1df9kFyY/Xxeb3SfB1v4CkmXDgQPxRr2ehm+OZ1+XKRfU9E8HdR7Peb+jgr47a
Ckk7GJPUXTpgQ36CkNmS1tsjhs3oNjiRNQjgeWinxGQaKvpmtu439oVEevGy3i2wckAdHYtl
FksvfDjw9WX7dWCMAfGtcV2BgVpBrrt8/e0UkveqD8eY3axJwQYlu5f+GhKsVXnIUeDl1MR7
QyburTdGdbdKNB09Ul9MqesDprNqJLm7Dct1+yJZFhDxecMRl7e51gqtUl9OHmdDfmAE1W7J
HJQsfSEWpq7FPauuPuYZ5tWeO5I2FgRVtCRDklWNVc4chn9FzEA5o2u+GR/Gl+22rRdIHCFp
pyyAZkOzw1ZPm/XyqaPPeaSVpPOj3FtnMZb+DnEOWAebDFZ2RcVOpgD8GezZYQ2GGkmdLyaK
Hq5+Wz+ucK8ePIp0vIDxCLEKC8hefU0ylkWFwu4nc3lxVZXc6uHFVYx3N7X0ddMe03RpMk4X
DsQ9GiZAq+9NlafT1rV3IEbPxrcXEjnXD4W3ry02ubIy9pTYzsBkDau87awxOzP6U6ksfZHp
INzSdMFu4djcVJ6rmhjboTyw5iKgIm7b+Gz+rZeXmsENbK1028X+ae3u5Ai2uvcwnuUdjCcy
jbSgOYHNRL4rKGz6pSsfJSR5aXgeWvVvoY8I9f9ASjwT4B2fk7K6V5JGytMhSZve0m+z+fdu
r717zSP1J1CskWll2W7U6wZyp+8udXl6WYArPUVppw0b5YR+5F6zHBsu/jh2xkE+ia9uBhg3
DbPXL6/Avt/dwwDg+/z71i04r79vqMiwvjHDRgRaW13HRDVlOgfUQgvOrPA0KNeoWeleBAmy
+ybW+LIGZ7u7urj52Da3WhYVM1nlbd/G1ii3AjO0aS5z0BEsSWWh8rQsu0dLapqfvV+MyasM
gbebpj5ZO+CvxxjhujFQqjKsjNKy3kOqyapyTwrY7MZ12UwFGx+6KjwhIYYfIMvdK7zOVHVP
30EiMwgFNz+CaPF5//Vrr+PI0QniJpEbn3XtPcnyk7tQ0qjcZ8braVT4F9DGe4XUbB98dQp0
GFL/ADmzguutBIvuMxc11sR36YLApgUJn2WcwdL4tKzMz6GYpHfR2vQAACOCFJKT/Wutt8ls
9bWjrOgPywJmGXbqtpZAINjHvH5tQyJNP5EF/BbjcpAmEFVFX+x14NWEpaW4u+gCMYNRpb0b
tOZ5bU0Nrhkl8mhoRHpkxBXGQhRUFohkPIl28HbbJIPb/w1e9rvFPwv4AVtt3rlmmz5/YMp+
i2dfFvDpx9kmhOm0RsJu/mnBLG0SalwXCZ1RIw0e/mww5CbAavGZRZquT5MCyX6yF+zdxg53
I9IYa3b0Od2iIIa21MOniidRO9KhmcwTbh/ew57Z2rg2E+etBPyDcChURgztBD6bOGfM5M8w
zDkj5mJC6XsaUuNwLSKRW8mIwAJfxdHW2PHf92iueciIL+LcyzSPb/spo9wE+ArmLMa/msbP
SPc88JMZlpj72vOpcXza7/IO9K6E1kqDXflLDFoiWyE79jeSOG0Zisucnx68tR5sd6EjzYqE
xokecoZ6FveezNUT1EFi5jwEuAqudP91SdN1V0/uGNp/6sKbgfUsJyCOQM09RZ6n0w84Uksc
vheFWNEutruezLkeKvfMyPguqMLTE3Z8p+GXiNA92fTCa8N0e3PeQrgNJeLe2z3mEDCOzEdN
QxytiA5vDIjWU0FzCO6xYOyHh9JmnpKGg5elp+TgoBofqLiX62fO6kvPO++Pzuwg8r4whUjG
S2cXjuX10zGQMl36E2zDsiL1P/JyV4rjUdR524a/01JweCRiqjI0LMf+6dz38tJhnDEfEY/T
0gyLNGYx32+Wux9UJjQWD54UVfBSS/sAhBfGlezcm5ezuHQOgVRJmAYPAIEOVhe4Kh5qx49X
3NRbqQF6t5m8B/T5VgsGCXGwDX/YLHokXW0kT+dlrbvDPrT7BwuwDkNHdaHMmWvc7+tTHact
P29mkIVs1nuwQItWOnx8i2d1zoFKMTYE4hmI53qAkorcA8VWZqk6rfnHPxnQ6eHimlecS+tp
49b8kr4cw3H28iKStLlAsLTgFH3Qa7q4ChC6ayOVoRvl+wMNnL7mO/1pkEMPdUMG2mi7JrDr
q/NG+f4R5IKeoAZVIf+L1ASDPOm+8sBP6Li6zyjwO1i8DqPA+Xm2HUV09OP+FIT3TXbz2sIH
7L8/aFss9wYO/zAAk3nn3QDDB/ntUf8Plb6JnERHAAA=

--J2SCkAp4GZ/dPZZf--
