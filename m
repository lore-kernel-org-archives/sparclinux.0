From: Marcel Holtmann <marcel@holtmann.org>
Date: Wed, 14 Apr 2004 20:15:55 +0000
Subject: Compile problem with sparc64
Message-Id: <1081973754.3372.5.camel@pegasus>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: SPARC Linux Mailing List <sparclinux@vger.kernel.org>

Hi,

the changeset

ChangeSet@1.1713.27.238, 2004-04-12 13:31:10-07:00, akpm@osdl.org
  [PATCH] binfmt_elf.c fix for 32-bit apps with large bss

causes this compile problem on sparc64

  CC      arch/sparc64/kernel/binfmt_elf32.o
In file included from arch/sparc64/kernel/binfmt_elf32.c:154:
fs/binfmt_elf.c: In function `load_elf_interp':
fs/binfmt_elf.c:369: warning: comparison is always false due to limited range of data type
fs/binfmt_elf.c: In function `load_elf_binary':
fs/binfmt_elf.c:780: warning: comparison is always false due to limited range of data type

Regards

Marcel


