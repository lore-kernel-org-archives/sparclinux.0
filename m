From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 10 Dec 2005 08:18:04 +0000
Subject: Fw: Need for VM_INCOMPLETE on I/O mappings
Message-Id: <20051210.001804.21312408.davem@davemloft.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--Next_Part(Sat_Dec_10_00_18_04_2005_287)--"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

----Next_Part(Sat_Dec_10_00_18_04_2005_287)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Can you guys try out this patch from Hugh Dickins?  It should
fix the memory management problems, but I do not promise it
will make the X server work fully :)

Thanks.

----Next_Part(Sat_Dec_10_00_18_04_2005_287)--
Content-Type: Message/Rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Return-path: <hugh_dickins@symantec.com>
Envelope-to: davem@davemloft.net
Received: from silver.veritas.com ([143.127.12.111])
	by sunset.davemloft.net with esmtp (Exim 4.54)
	id 1EkLwH-0002Ft-2I
	for davem@davemloft.net; Thu, 08 Dec 2005 05:36:01 -0800
Received: from unknown (HELO dub1xchecnpin02.enterprise.veritas.com) ([166.98.48.152])
  by silver.veritas.com with ESMTP; 08 Dec 2005 05:35:00 -0800
Received: from SVLXCHCON2.enterprise.veritas.com ([10.137.18.172]) by dub1xchecnpin02.enterprise.veritas.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 8 Dec 2005 13:34:58 +0000
Received: from megami.veritas.com ([10.137.16.7]) by SVLXCHCON2.enterprise.veritas.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 8 Dec 2005 05:34:56 -0800
Received: from linux.wat.veritas.com([10.10.97.50]) (2896 bytes) by megami.veritas.com
	via sendmail with P:esmtp/R:smart_host/T:smtp
	(sender: <hugh@veritas.com>) 
	id <m1EkLvD-0001IvC@megami.veritas.com>
	for <torvalds@osdl.org>; Thu, 8 Dec 2005 05:34:55 -0800 (PST)
	(Smail-3.2.0.101 1997-Dec-17 #15 built 2001-Aug-30)
Date: Thu, 8 Dec 2005 13:34:52 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>
cc: torvalds@osdl.org, akpm@osdl.org
Subject: Re: Need for VM_INCOMPLETE on I/O mappings
In-Reply-To: <20051207.170752.76354146.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0512081325230.8142@goblin.wat.veritas.com>
References: <20051207.170752.76354146.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 08 Dec 2005 13:34:56.0391 (UTC) FILETIME=[2D846970:01C5FBFC]

On Wed, 7 Dec 2005, David S. Miller wrote:
> 
> The VM_INCOMPLETE scheme can't be used to handle my case, since that
> only works for pfn_valid() real pages of memory, not for I/O pages
> which have no backing page struct.

Thank you for describing this case, Dave.  Thank goodness you found it
now and not later.  There may be other examples we haven't stumbled on
yet.  Linus was taking a risk with his vm_pgoff approach: we all thought
it was a reasonable risk (just as earlier on we thought it a reasonable
risk to reject MAP_PRIVATE,PROT_WRITE), but it hasn't paid off.

> I'm kind of in a pickle about how to handle this.  I guess we could
> "split" the VMA at the top level somehow, but that seems like a lot of
> work for something so seemingly simple.

Perhaps.  Very ugly.  Much more so than the existing use of
incomplete_pfn_remap.

My answer is the same as it has been all along: 2.6.15-rc2-git6.
That will have had no problem with your case.

I'll take a careful look at what's changed between then and now
and try to come up with a patch combining the best of both.
(But if that looks too much, fall back to your vma split idea.)

vm_insert_page is fine, VM_PFNMAP is fine.  incomplete_pfn_remap
and VM_INCOMPLETE and the vm_pgoff changes should go.  I'll try
to fit my page_is_anon inside Linus' vm_normal_page, I don't know
if that will work out or not.

And once I've got something that really works, then see if I can
somehow make it more palatable for Linus on his return.  That's
the hard part.

> It's a shame that we've allowed so much cruft to accumulate in these
> driver mmap()s.  I wish I had known years ago the implications of
> allowing discontiguous I/O mappings within a single VMA. :-/

No, what it was doing was permitted, and we should still permit it.
Could deprecate it over several releases if we feel strongly that
it's wrong (I don't), but we must not break it right now.

The good news, by the way, is that the ATI situation looks solved:
it was carefully "#if 0"ing a get_page on a PageReserved page in
its wrapper, with warning comment on why: they just need to make
that conditional on LINUX_VERSION, because that oddity is just
what Nick got rid of.

Hugh

----Next_Part(Sat_Dec_10_00_18_04_2005_287)----
