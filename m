From: David Miller <davem@redhat.com>
Date: Fri, 24 Feb 2017 03:11:32 +0000
Subject: Re: [sparc:master 7/9] arch/sparc/mm/tsb.c:155:3: error: implicit declaration of function '__flush_h
Message-Id: <20170223.221132.100829704657346543.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201702240851.vBtmGSbs%fengguang.wu@intel.com>
In-Reply-To: <201702240851.vBtmGSbs%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Thu, 23 Feb 2017 17:31:29 -0800

> Hi David,
> 
> On 02/23/2017 04:20 PM, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master
>> head:   cd429ce2d095041d249ec85feaed608bbf72154f
>> commit: dcd1912d21a02534d1f0a9005d5ba3283f164780 [7/9] sparc64: Add 64K page size support
>> config: sparc64-allnoconfig (attached as .config)
>> compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> 
> I'm working on fixing this commit and will send a v2 soon.

The commit is not going to be reverted.  So it's not appropriate
so submit a "v2", but rather you need to send a bug fix relative
to the existing change.
