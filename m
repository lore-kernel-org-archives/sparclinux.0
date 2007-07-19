From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Thu, 19 Jul 2007 16:58:27 +0000
Subject: Re: [PATCH 03/12] Consolidate of_device_is_compatible
Message-Id: <3E555E76-1182-4C67-9368-E7E0F4756E69@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
	<20070720011012.4eca281d.sfr@canb.auug.org.au>
	<20070719155207.GA28617@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070719155207.GA28617@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scott Wood <scottwood@freescale.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, wli@holomorphy.com, ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

>> The only difference here is that Sparc uses strncmp to match  
>> compatibility
>> names while PowerPC uses strncasecmp.
>
> Could we put a comment in saying that both should really just use
> strcmp(), and that this mechanism should go away once any  
> compatibility
> issues are found and addressed?
>
> The PowerPC one will need to drop the 'n' soon, as well, but that  
> should
> be a separate patch.

I think both of these are on enough to-do lists that adding
a comment isn't necessary ;-)


Segher

