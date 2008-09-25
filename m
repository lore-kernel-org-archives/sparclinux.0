From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Thu, 25 Sep 2008 16:58:21 +0000
Subject: Re: KVM for Sparc?
Message-Id: <f43fc5580809250958r16f6b0c6u655ad3d2e954a0d6@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080923.133856.141663278.davem@davemloft.net>
	 <f43fc5580809241020j2b1d885ci8552b5c5302a89d5@mail.gmail.com>
	 <f43fc5580809241106j7780be0et384ee4b98082765b@mail.gmail.com>
	 <20080924.122952.186900852.davem@davemloft.net>
In-Reply-To: <20080924.122952.186900852.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: anthony@codemonkey.ws, kvm@vger.kernel.org, sparclinux@vger.kernel.org, levon@movementarian.org, hollisb@us.ibm.com

On 9/24/08, David Miller <davem@davemloft.net> wrote:
> From: "Blue Swirl" <blauwirbel@gmail.com>
>
> Date: Wed, 24 Sep 2008 21:06:21 +0300
>
>
>  > Now I found the relevant part in the manuals. The extra sun4v bit is
>  > not taken into account from user mode, so we can't catch privileged to
>  > hyperprivileged mode traps easily.
>
>
> That's right, the top bit is ignored in user mode.

The hypervisor uses traps 0x80, 0x83, 0x84, 0x85, and 0xff. Looking at
how these alias to low number traps: first four are unused or used for
resets (SIR, RED, XIR), so they are not in the fast path. 0xff aliases
to 0x7f, which is part of Fill 7 otherwin trap. Maybe that is not
performance critical? The Fill 7 trap entry could be shortened with
off-table jumps.

I'm thinking that we could disassemble the calling instruction on
entry to the lower traps and detect what was the true cause of the
trap.
