From: Ralph Mitchell <rmitchell@eds.com>
Date: Sat, 28 Aug 2004 07:06:54 +0000
Subject: Re: [PATCH] SunSAB console problems in 2.6.x
Message-Id: <41302F0E.7060302@eds.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040825233247.237c1fb1.davem@redhat.com>
In-Reply-To: <20040825233247.237c1fb1.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Works just fine.  Thanks!  Took me a minute to realise it was a patch 
against 2.6.9-rc1, though.  Are there any stability issues with this 
RC?  If not, I'll leave it running, otherwise I'll go back to 2.6.8.

Works even better with PREEMPT off.  Thought I probably had something 
stupid in the .config  :)

Thanks,

Ralph Mitchell


David S. Miller wrote:

>On Fri, 27 Aug 2004 17:01:01 -0700
>Joshua Kwan <joshk@triplehelix.org> wrote:
>
>  
>
>>>-	 mcount.o ipcsum.o rwsem.o xor.o splock.o find_bit.o
>>>+	 mcount.o ipcsum.o rwsem.o xor.o splock.o find_bit.o delay.o
>>> 
>>> lib-$(CONFIG_DEBUG_SPINLOCK) += debuglocks.o
>>> lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
>>>      
>>>
>>You forgot delay.c.
>>    
>>
>
>Sorry, I'm a retard.
>
>This patch should be better.
>
># This is a BitKeeper generated diff -Nru style patch.
>#
># ChangeSet
>#   2004/08/27 16:12:23-07:00 davem@nuts.davemloft.net 
>#   [SPARC64]: Fix delay with HZ=1000.
>  
>
