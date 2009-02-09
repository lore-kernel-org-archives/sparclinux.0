From: seb@frankengul.org
Date: Mon, 09 Feb 2009 09:58:03 +0000
Subject: 2.6.29-rc4 missing __raw_spin_is_contended
Message-Id: <20090209095803.GA6396@frankengul.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

Hi,

I'm trying to compile the 2.6.29-rc4 on sparc64 (V240).
The compilation is breaking here :
  CHK     include/linux/compile.h
  CC [M]  fs/btrfs/locking.o
fs/btrfs/locking.c: In function ‘btrfs_path_lock_waiting’:
fs/btrfs/locking.c:254: error: implicit declaration of function ‘__raw_spin_is_contended’

I had a look at the spinlock_64.h on sparc and did a quick comparison with the x86's one.
The 2 implementation are really different and relies heavily on asm (Maybe it's time I 
learn asm for x86 and sparc...).

	Seb

