From: David Miller <davem@davemloft.net>
Date: Sun, 07 Jun 2020 23:40:29 +0000
Subject: Re: [git pull] a couple of sparc ptrace fixes
Message-Id: <20200607.164029.2024393765839829686.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200531010414.GW23230@ZenIV.linux.org.uk>
        <20200607144152.GM23230@ZenIV.linux.org.uk>
In-Reply-To: <20200607144152.GM23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viro@zeniv.linux.org.uk
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sun, 7 Jun 2020 15:41:52 +0100

> On Sun, May 31, 2020 at 02:04:14AM +0100, Al Viro wrote:
>> The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:
>> 
>>   Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)
>> 
>> are available in the git repository at:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-davem
>> 
>> for you to fetch changes up to cf51e129b96847f969bfb8af1ee1516a01a70b39:
>> 
>>   sparc32: fix register window handling in genregs32_[gs]et() (2020-05-20 13:29:37 -0400)
>> 
>> ----------------------------------------------------------------
>> Al Viro (2):
>>       sparc64: fix misuses of access_process_vm() in genregs32_[sg]et()
>>       sparc32: fix register window handling in genregs32_[gs]et()
>> 
>>  arch/sparc/kernel/ptrace_32.c | 228 ++++++++++++++++++------------------------
>>  arch/sparc/kernel/ptrace_64.c |  17 +---
>>  2 files changed, 101 insertions(+), 144 deletions(-)
> 
> Grrr...  
> 
> sparc32 fix had breakage of its own; I've pushed a fix into #for-davem.  Fixup
> follows.  Could you pull it?

Done.
