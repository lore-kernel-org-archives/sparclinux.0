From: David Miller <davem@davemloft.net>
Date: Wed, 21 Feb 2007 00:44:11 +0000
Subject: Re: E450 and kernel > 2.6.18
Message-Id: <20070220.164411.59657496.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <45D4C105.8020802@mydatex.cz>
In-Reply-To: <45D4C105.8020802@mydatex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eki <eki@sci.fi>
Date: Tue, 20 Feb 2007 12:41:19 +0200

> IIRC, 2.6.17.14 was the last kernel that I booted successfully on
> E450. 2.6.18-rc1 didn't work any more. There seems to be alot of
> patches to the PCI code that was added after 2.6.17 that seems
> to break the IRQ routing (or something).
> 
> Perhaps the breakage is introduced by one of these commits?:
> 
>  commit 46ba6d7d8b0486e9d565729880ddfb2b84d3af31
>   [SPARC64]: Fix more of_device layer IRQ bugs, and correct PROMREG_MAX.
>   
>  commit ee7022dcfbf660727d6b8553cb0dbc0d4eae8f44
>   [SPARC64] Fix PSYCHO PCI controler init.
>   
>  commit a49261585e2c89f16b5a4bb80f623d2e9c2c1566
>   [SPARC64] psycho: Fix pbm->name handling in pbm_register_toplevel_resources()

Please send the full "/usr/sbin/prtconf -pv" output from this machine,
and then boot the non-working 2.6.20 kernel with the "of_debug=3"
kernel command line option and capture all of the boot messages
and send that as well.

Thanks.
