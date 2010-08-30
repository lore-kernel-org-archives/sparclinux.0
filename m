From: Andres Salomon <dilinger@queued.net>
Date: Mon, 30 Aug 2010 03:51:00 +0000
Subject: [PATCH 0/9] add OLPC device-tree support
Message-Id: <20100829235100.6dcedcb8@debxo>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian>
In-Reply-To: <20100628215407.2017bf2f@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, cjb@laptop.org, Mitch Bradley <wmb@laptop.org>, pgf@laptop.org, linux-kernel@vger.kernel.org, davem@davemloft.net, grant.likely@secretlab.ca, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

These patches modify drivers/of, sparc, and x86 accordingly to add
OLPC device-tree support.  Updates have been made based upon Grant and
Davem's comments.  They've been compile-tested on sparc64 and x86, and
runtime tested on OLPC machines.

Dave's 25edd6946 commit caused some conflicts w/ patch #2;
hopefully I mangled it properly.
