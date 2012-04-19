From: David Miller <davem@davemloft.net>
Date: Thu, 19 Apr 2012 17:47:18 +0000
Subject: Re: [PATCH] net: filter: Just In Time compiler for sparc
Message-Id: <20120419.134718.1020535231461282160.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120417195716.GA26750@merkur.ravnborg.org>
	<20120417.164400.89608576188768018.davem@davemloft.net>
	<20120419152937.GA1120@merkur.ravnborg.org>
In-Reply-To: <20120419152937.GA1120@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 19 Apr 2012 17:29:37 +0200

>> 
>> >> +	select HAVE_BPF_JIT
>> > If we sorted this block of select then the chances
>> > for merge conflict would be smaller.
>> > But this is not this patch to do so.
>> 
>> I also think we should create an arch/sparc/Kbuild for sparc
>> too, just like x86 has.
> 
> I will look into both issues.
> But only after the merge window to avoid conflicts.

Thanks a lot Sam.
