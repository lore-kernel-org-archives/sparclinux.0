From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jul 2017 21:52:04 +0000
Subject: Re: [PATCH] tty: Convert to using %pOF instead of full_name
Message-Id: <20170718.145204.114892351718806712.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170718214339.7774-54-robh@kernel.org>
In-Reply-To: <20170718214339.7774-54-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh@kernel.org
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, jslaby@suse.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org

From: Rob Herring <robh@kernel.org>
Date: Tue, 18 Jul 2017 16:43:34 -0500

> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

For sparc bits:

Acked-by: David S. Miller <davem@davemloft.net>
