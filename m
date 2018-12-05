From: David Miller <davem@davemloft.net>
Date: Wed, 05 Dec 2018 19:55:12 +0000
Subject: Re: [PATCH] tty: Use of_node_name_{eq,prefix} for node name comparisons
Message-Id: <20181205.115512.2208490264846443236.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181205195050.4759-27-robh@kernel.org>
In-Reply-To: <20181205195050.4759-27-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, gregkh@linuxfoundation.org, jslaby@suse.com, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org

From: Rob Herring <robh@kernel.org>
Date: Wed,  5 Dec 2018 13:50:43 -0600

> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> For hvc, the code can also be simplified by using of_stdout pointer
> instead of searching again for the stdout node.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-serial@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
