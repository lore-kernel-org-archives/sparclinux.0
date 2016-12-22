From: Anatoly Pugachev <matorola@gmail.com>
Date: Thu, 22 Dec 2016 14:58:18 +0000
Subject: Re: [PATCH v6 1/2] sparc: fix a building error reported by kbuild
Message-Id: <CADxRZqwVBXksG=ChgvPe9sJAw45v48u4k0VYV=VLmeporujYDg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1481171829-116496-1-git-send-email-arei.gonglei@huawei.com>
 <1481171829-116496-2-git-send-email-arei.gonglei@huawei.com>
 <20161209215851.GA7717@ravnborg.org> <33183CC9F5247A488A2544077AF19020DA159386@DGGEMA505-MBX.china.huawei.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA159386@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, virtio-dev@lists.oasis-open.org

Guys,

so was it fixed or not?

I can not compile current git kernel:

linux-2.6$ git desc
v4.9-11937-g52bce91165e5

linux-2.6$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working tree clean

linux-2.6$ git log --oneline arch/sparc/include/asm/topology_64.h | head -1
541cc39433a8 sparc: fix a building error reported by kbuild

linux-2.6$ make
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
<stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
<stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
<stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
  CHK     include/generated/compile.h
  GEN     usr/initramfs_data.cpio".gz"
  AS      usr/initramfs_data.o
  LD      usr/built-in.o
  CHK     kernel/config_data.h
  CC [M]  drivers/crypto/virtio/virtio_crypto_mgr.o
In file included from ./arch/sparc/include/asm/topology.h:4:0,
                 from ./include/linux/topology.h:35,
                 from ./include/linux/gfp.h:8,
                 from ./include/linux/kmod.h:22,
                 from ./include/linux/module.h:13,
                 from drivers/crypto/virtio/virtio_crypto_mgr.c:21:
drivers/crypto/virtio/virtio_crypto_common.h: In function
‘virtio_crypto_get_current_node’:
./arch/sparc/include/asm/topology_64.h:45:44: error: implicit
declaration of function ‘cpu_data’
[-Werror=implicit-function-declaration]
 #define topology_physical_package_id(cpu) (cpu_data(cpu).proc_id)
                                            ^
drivers/crypto/virtio/virtio_crypto_common.h:119:9: note: in expansion
of macro ‘topology_physical_package_id’
  node = topology_physical_package_id(cpu);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
./arch/sparc/include/asm/topology_64.h:45:57: error: request for
member ‘proc_id’ in something not a structure or union
 #define topology_physical_package_id(cpu) (cpu_data(cpu).proc_id)
                                                         ^
drivers/crypto/virtio/virtio_crypto_common.h:119:9: note: in expansion
of macro ‘topology_physical_package_id’
  node = topology_physical_package_id(cpu);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
scripts/Makefile.build:293: recipe for target
'drivers/crypto/virtio/virtio_crypto_mgr.o' failed
make[3]: *** [drivers/crypto/virtio/virtio_crypto_mgr.o] Error 1
scripts/Makefile.build:551: recipe for target 'drivers/crypto/virtio' failed
make[2]: *** [drivers/crypto/virtio] Error 2
scripts/Makefile.build:551: recipe for target 'drivers/crypto' failed
make[1]: *** [drivers/crypto] Error 2
Makefile:988: recipe for target 'drivers' failed
make: *** [drivers] Error 2
linux-2.6$
