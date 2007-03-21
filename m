From: bertrand <joel.bertrand@systella.fr>
Date: Wed, 21 Mar 2007 12:26:42 +0000
Subject: Re: [Repost] Ultra2 SMP freezes with heavy disk I/O
Message-Id: <46012482.2020302@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20070320180102.GA27466@rayleigh.systella.fr>
In-Reply-To: <20070320180102.GA27466@rayleigh.systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

Ferris McCormick a écrit :
> On Wed, 2007-03-21 at 10:53 +0100, bertrand wrote:
>> Ferris McCormick a écrit :
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
> 
> --- snip ---
> 
>>>> 	JKB
>>> This is a problem with U2+kernel-2.6.x generally.  Unfortunately, I
>>> have no suggestions nor do I have a solution. I just grit my teeth and
>>> stay with the kernel-2.4.x series, which are completely stable on U2,
>>> so far as I can tell.
>> 	What is your U2 configuration ? I have only one U2 and I cannot test on 
>> this station because it's a mail server :-( In fact, I think it should 
>> be interesting to know if this trouble come from SMP, ESP or Sbus 
>> support. It is impossible to build a kernel with debug information (it 
>> does not boot due to a address not aligned...), but I have tested the 
>> same kernel on a U1E (with the same ESP chip and two additional 
>> HappyMeal Ethernet cards on Sbus slots). It perfectly works. Can you try 
>> a 2.6 on U2 without SMP support ?
>>
>> 	Regards,
>>
>> 	JKB
> 
> I have 2 U2's; U2(2x300), U2(2x400).  The SMP doesn't matter, though; U2
> with 2.6.x will freeze eventually even if a uniprocessor.

	I have seen your post on gentoo-sparc mailing list. I have made some 
search to find more posts wihtout any success. I'm not sure this trouble 
was known, I haven't seen any post on kernel mailing list.

> SMP just lets
> it fail more quickly.  Problem is believed to be SCSI or Sbus, I think,
> but I don't know that anyone is sure.  The kernel people have known
> about this for well over a year, but no fix.

	I have seen some posts about ESP troubles. For me, all ESP troubles 
were fixed on sparc64.

> For more current information, you might ask squash@gentoo.org or
> weeve@gentoo.org --- I haven't tried 2.6 on U2 for a while because no
> one has claimed to have a fix for this problem.  (Gentoo spent a lot of
> time on this freeze a few months ago, but no satisfaction.  I am sure,
> though, that we ruled out SMP as the problem.)

	I have seen you have tried to build a 2.6 kernel with gcc-3.3 and 3.4. 
I have tried 4.0 and 4.1 with the same result.

	Regards,

	JKB
