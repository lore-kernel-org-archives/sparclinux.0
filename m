From: David Miller <davem@davemloft.net>
Date: Tue, 21 May 2019 01:43:36 +0000
Subject: Re: [PATCH v2] vmalloc: Fix issues with flush flag
Message-Id: <20190520.184336.743103388474716249.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <3e7e674c1fe094cd8dbe0c8933db18be1a37d76d.camel@intel.com>
	<20190520.203320.621504228022195532.davem@davemloft.net>
	<a43f9224e6b245ade4b587a018c8a21815091f0f.camel@intel.com>
In-Reply-To: <a43f9224e6b245ade4b587a018c8a21815091f0f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rick.p.edgecombe@intel.com
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, linux-mm@kvack.org, mroos@linux.ee, mingo@redhat.com, namit@vmware.com, luto@kernel.org, bp@alien8.de, netdev@vger.kernel.org, dave.hansen@intel.com, sparclinux@vger.kernel.org

From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Tue, 21 May 2019 01:20:33 +0000

> Should it handle executing an unmapped page gracefully? Because this
> change is causing that to happen much earlier. If something was relying
> on a cached translation to execute something it could find the mapping
> disappear.

Does this work by not mapping any kernel mappings at the beginning,
and then filling in the BPF mappings in response to faults?
