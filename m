From: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 06 Dec 2018 03:34:56 +0000
Subject: Re: [PATCH] tty: Use of_node_name_{eq,prefix} for node name comparisons
Message-Id: <87ftvbl44f.fsf@concordia.ellerman.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20181205195050.4759-27-robh@kernel.org>
In-Reply-To: <20181205195050.4759-27-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "David S. Miller" <davem@davemloft.net>, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

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
> ---
>  drivers/tty/hvc/hvc_opal.c      |  2 +-
>  drivers/tty/hvc/hvc_vio.c       | 11 +----------
>  drivers/tty/serial/pmac_zilog.c |  4 ++--

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
