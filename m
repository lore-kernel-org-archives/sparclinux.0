From: David Johnson <dj@david-web.co.uk>
Date: Tue, 23 Jan 2007 13:54:16 +0000
Subject: Re: IRQ routing(?) problem on Enterprise 450 with Areca SATA RAID controller
Message-Id: <200701231354.16461.dj@david-web.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20070102140325.GB11095@wopr.homeunix.org>
In-Reply-To: <20070102140325.GB11095@wopr.homeunix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thursday 18 January 2007 20:40, you wrote:
>
> Hello,
>
> Haven't seen any response on this issue yet. Doesn't anybody else have
> similar problems with PCI-X cards on E450?
>

I'm still seeing my problem (which you linked in your original message).

I tried to look into this a little, but didn't get anywhere. It looks like our 
last known-good kernel is 2.6.17.14 (I tested this also).

I suspect the breakage is in 2.6.18-rc1, but there seems to be a critical bug 
in this kernel which prevents it from even booting on E450 (it gets as far 
as 'Booting the kernel' and just sits there, giving no errors or other 
output) so I can't test this. As a result, I am unable to bisect the tree to 
find the patch that introduced the bug...

It would be useful if someone could test 2.6.18-rc2 to see if that contains 
the bug. If it doesn't, then it must have come in with -rc3 or -rc4 (I can 
confirm that it is present in -rc4) which means I can bisect the tree to find 
the bad patch. If -rc2 does contain the bug, there's not much we can do 
unless someone can give me a working config for 2.6.18-rc1.

Just to be clear, so far we have:
2.6.17.x - GOOD
2.6.18-rc1 - ?
2.6.18-rc2 - ?
2.6.18-rc3 - ?
2.6.18-rc4 - BAD

Unfortunately I can't test these myself, as I won't have access to my machine 
now for two weeks. If we can fill in the gaps above by then and figure out 
where the problem lies, I can hopefully dedicate some time to tracking this 
rather annoying problem down.

Regards,
David.

-- 
David Johnson
www.david-web.co.uk
