From: Tim Abbott <tabbott@ksplice.com>
Date: Wed, 16 Sep 2009 17:27:43 +0000
Subject: Re: [PATCH v2] sparc: Clean up linker script using new linker script
Message-Id: <alpine.DEB.1.10.0909161322260.2942@dr-wily.mit.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <1253119592-19598-1-git-send-email-tabbott@ksplice.com> <1253119592-19598-2-git-send-email-tabbott@ksplice.com> <20090916.101924.186960949.davem@davemloft.net>
In-Reply-To: <20090916.101924.186960949.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org, geofft@ksplice.com

On Wed, 16 Sep 2009, David Miller wrote:

> Can you do this cleanup without moving the relative locations of .data
> and .data1 sections?

Yes, if you just swap RW_DATA_SECTION and .data1 so it looks like

RW_DATA_SECTION(SMP_CACHE_BYTES, 0, THREAD_SIZE)
.data1 : {
	*(.data1)
}

instead, that would preserve their relative locations.

Currently, switching to RW_DATA_SECTION would still result in a change in 
their relative position that .data.page_aligned and .data.nosave would be 
between .data and .data1 (not sure if that is relevant on sparc). (this 
will change when <http://lkml.org/lkml/2009/9/16/396> is merged).

	-Tim Abbott


