From: David Miller <davem@davemloft.net>
Date: Tue, 21 May 2019 00:33:20 +0000
Subject: Re: [PATCH v2] vmalloc: Fix issues with flush flag
Message-Id: <20190520.203320.621504228022195532.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <c6020a01e81d08342e1a2b3ae7e03d55858480ba.camel@intel.com>
	<20190520.154855.2207738976381931092.davem@davemloft.net>
	<3e7e674c1fe094cd8dbe0c8933db18be1a37d76d.camel@intel.com>
In-Reply-To: <3e7e674c1fe094cd8dbe0c8933db18be1a37d76d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rick.p.edgecombe@intel.com
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, linux-mm@kvack.org, mroos@linux.ee, mingo@redhat.com, namit@vmware.com, luto@kernel.org, bp@alien8.de, netdev@vger.kernel.org, dave.hansen@intel.com, sparclinux@vger.kernel.org

From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Tue, 21 May 2019 00:20:13 +0000

> This behavior shouldn't happen until modules or BPF are being freed.

Then that would rule out my theory.

The only thing left is whether the permissions are actually set
properly.  If they aren't we'll take an exception when the BPF program
is run and I'm not %100 sure that kernel execute permission violations
are totally handled cleanly.
