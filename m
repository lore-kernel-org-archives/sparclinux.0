From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Fri, 15 Aug 2008 11:09:20 +0000
Subject: Re: Bootmem allocator broken
Message-Id: <a4423d670808150409j6df13225o7434fc6c223913f7@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0808130845290.8416@hs20-bc2-1.build.redhat.com>
	 <20080813.202559.193705172.davem@davemloft.net>
	 <Pine.LNX.4.64.0808141855500.15262@hs20-bc2-1.build.redhat.com>
	 <20080814.162519.181180629.davem@davemloft.net>
In-Reply-To: <20080814.162519.181180629.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mpatocka@redhat.com, hannes@saeurebad.de, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

2008/8/15 David Miller <davem@davemloft.net>:
> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Thu, 14 Aug 2008 19:11:19 -0400 (EDT)
>
> [ Adding Alexander back to the CC: as he is seeing this same
>  exact bug too, please keep him in the loop for testing. ]

>> This patch fixes it (kernels 2.6.27-rc2 and 2.6.27-rc3 boot ok after the
>> patch). Johannes, please review the patch and submit it to Linus.
>>
>> With the patch it tries to continue at the end of previous allocation only
>> if the previous allocation ended in the middle of the page.
>>
>> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>


It is working! Thanks a lot David and Mikulas!

alexb@sparky ~ $ zgrep LOCKDEP /proc/config.gz
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
alexb@sparky ~ $ uname -a
Linux sparky 2.6.27-rc3-00171-gb635ace-dirty #3 PREEMPT Fri Aug 15
14:52:40 MSD 2008 sparc64 sun4u TI UltraSparc IIi (Sabre) GNU/Linux
