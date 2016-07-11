From: David Sterba <dsterba@suse.cz>
Date: Mon, 11 Jul 2016 10:06:46 +0000
Subject: Re: btrfs module does not load on sparc64
Message-Id: <20160711100646.GS13336@twin.jikos.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwhBoc9sNxxZ4a9ZJ0JiYWiL9xtG8T_ws4i61YrtNHtHg@mail.gmail.com>
In-Reply-To: <CADxRZqwhBoc9sNxxZ4a9ZJ0JiYWiL9xtG8T_ws4i61YrtNHtHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatoly Pugachev <matorola@gmail.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>, sparclinux@vger.kernel.org, debian-sparc <debian-sparc@lists.debian.org>

On Thu, Jul 07, 2016 at 05:29:35PM +0300, Anatoly Pugachev wrote:
> Compiled linux kernel (git version 4.7.0-rc6+) using my own kernel
> config file, enabling :
> 
> CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
> CONFIG_BTRFS_DEBUG=y
> CONFIG_BTRFS_ASSERT=y
> 
> and now I can't load btrfs module:
> 
> # modprobe btrfs
> modprobe: ERROR: could not insert 'btrfs': Invalid argument
> 
> 
> and in logs (and on console):
> 
> [1897399.942697] Btrfs loaded, crc32c=crc32c-generic, debug=on, assert=on
> [1897400.024645] BTRFS: selftest: sectorsize: 8192  nodesize: 8192
> [1897400.098089] BTRFS: selftest: Running btrfs free space cache tests
> [1897400.175863] BTRFS: selftest: Running extent only tests
> [1897400.241871] BTRFS: selftest: Running bitmap only tests
> [1897400.307877] BTRFS: selftest: Running bitmap and extent tests
> [1897400.380329] BTRFS: selftest: Running space stealing from bitmap to extent
> [1897400.470517] BTRFS: selftest: Free space cache tests finished
> [1897400.542875] BTRFS: selftest: Running extent buffer operation tests
> [1897400.621710] BTRFS: selftest: Running btrfs_split_item tests
> [1897400.692929] BTRFS: selftest: Running extent I/O tests
> [1897400.757459] BTRFS: selftest: Running find delalloc tests
> [1897401.082670] BTRFS: selftest: Running extent buffer bitmap tests
> [1897401.161223] BTRFS: selftest: Setting straddling pages failed

The sanity tests fail at some point with EINVAL, so the module will fail
to load in turn. Looking at the test itself (__test_eb_bitmaps), it does
no make any assumptions about page size etc. so this "should work".
Taking powerpc with 64k page size for another reference where the tests
work, I'm not sure what exactly could be wrong here.
