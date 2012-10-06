From: David Miller <davem@davemloft.net>
Date: Sat, 06 Oct 2012 02:43:43 +0000
Subject: Re: [RESEND PATCH 1/2] sparc64: Rearrange thread info to cheaply clear syscall noerror state.
Message-Id: <20121005.224343.818865635804771508.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20121004.174812.706050126936137696.davem@davemloft.net>
In-Reply-To: <20121004.174812.706050126936137696.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Sat, 6 Oct 2012 00:26:51 +0100

> On Fri, Oct 05, 2012 at 05:48:42PM -0400, David Miller wrote:
>> 
>> Al, this change turns out to be broken.
>> 
>> If you move the WSAVED byte down past bit 16, it runs into the bit
>> mask we for the _TI_* flag bits down lower in the file.
> 
> Umm...  Right you are.  I wonder why I hadn't stepped into that while
> testing that sucker... 

I tested it for 20 hours and didn't hit any problems, so don't feel
bad. :-)

> sparc64: clear syscall_noerror on the entry to syscall, not on the exit
>     
> Move that sucker to just before TI_FPDEPTH and replace stb with sth in
> etrap_save().  Take current_ds to its old place, so that we don't push
> wsaved into TI_... flags.  That allows to lose clearing syscall_noerror
> on return from syscall.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

I'll look at this later.
