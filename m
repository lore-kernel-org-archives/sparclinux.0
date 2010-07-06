From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jul 2010 07:16:07 +0000
Subject: Re: [PATCH 2/4] sparc: break out some prom device-tree building
Message-Id: <20100706.001607.186316276.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100707040734.05d625af@debxo>
	<20100705.192221.241453945.davem@davemloft.net>
	<AANLkTil3aZ0IF1KEc2h9MLHPZYW23pnWzEy4IiVb3zxT@mail.gmail.com>
In-Reply-To: <AANLkTil3aZ0IF1KEc2h9MLHPZYW23pnWzEy4IiVb3zxT@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: dilinger@queued.net, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, cjb@laptop.org, wmb@laptop.org, pgf@laptop.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 6 Jul 2010 01:00:06 -0600

> I'm curious... what are your plans here?  Will you be keeping OF alive
> between kexec()?  Will the new kernel get the entire device tree from
> fdt, or will it still be talking to OF?  How will the fdt fragments as
> Andres described above fit into sparc kexec (as opposed to generating
> one big tree as in his first option)?

On certain sparc64 systems, I have to stop making PROM calls early
in the boot right after I fetch the device tree into the kernel.

So yes for a kexec() I'll have to pass an fdt or similar to the
child kernel.

It could be a big linear fdt buffer, or fragments, it really doesn't
matter all that much actually.
