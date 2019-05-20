From: David Miller <davem@davemloft.net>
Date: Mon, 20 May 2019 22:48:55 +0000
Subject: Re: [PATCH v2] vmalloc: Fix issues with flush flag
Message-Id: <20190520.154855.2207738976381931092.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190520200703.15997-1-rick.p.edgecombe@intel.com>
	<90f8a4e1-aa71-0c10-1a91-495ba0cb329b@linux.ee>
	<c6020a01e81d08342e1a2b3ae7e03d55858480ba.camel@intel.com>
In-Reply-To: <c6020a01e81d08342e1a2b3ae7e03d55858480ba.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rick.p.edgecombe@intel.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, peterz@infradead.org, mroos@linux.ee, netdev@vger.kernel.org, sparclinux@vger.kernel.org, bp@alien8.de, luto@kernel.org, mingo@redhat.com, namit@vmware.com, dave.hansen@intel.com

From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Mon, 20 May 2019 22:17:49 +0000

> Thanks for testing. So I guess that suggests it's the TLB flush causing
> the problem on sparc and not any lazy purge deadlock. I had sent Meelis
> another test patch that just flushed the entire 0 to ULONG_MAX range to
> try to always the get the "flush all" logic and apprently it didn't
> boot mostly either. It also showed that it's not getting stuck anywhere
> in the vm_remove_alias() function. Something just hangs later.

I wonder if an address is making it to the TLB flush routines which is
not page aligned.  Or a TLB flush is being done before the callsites
are patched properly for the given cpu type.
