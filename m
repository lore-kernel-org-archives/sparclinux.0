From: Bob Breuer <breuerr@mc.net>
Date: Tue, 23 Nov 2004 15:35:47 +0000
Subject: Re: hypersparc dvma aliasing
Message-Id: <41A358D3.5070407@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <419AB742.1000103@mc.net>
In-Reply-To: <419AB742.1000103@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Stan Benoit wrote:
> On Tue, Nov 23, 2004 at 12:18:48AM -0600, Bob Breuer wrote:
> 
>>Hmmm, no reports on whether the previous patch works or 
>> not for anyone.
> 
>>diff -X dontdiff -urp linux-2.6.10-rc2-clean
> 
> 
> Bob are you using 2.6.10-rc2 from  
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/ 
> or linux-2.6.9 patched with your fixes? 
> Need a good start point. Both my Ross hypersparc 150 smp ss20 and 
> supersparc 75 smp ss20 have Aurora build 1.0 installed. 
> They are ready to go. 
> 

I've tried both kernels.  The previous 2 line fix made it into
2.6.10-rc2, so that is what I'm basing any future diffs off of.

I'd recommend upgrading Aurora to 1.92 because 1.0 may not support
a 2.6 kernel (see the aurora-sparc-user list archives for help).
Be sure to keep a 2.4 kernel around to fall back to.

If it will help anyone with testing, I may be able to provide an
already compiled kernel and modules.

Bob
