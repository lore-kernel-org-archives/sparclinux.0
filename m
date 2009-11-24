From: "J. Bruce Fields" <bfields@citi.umich.edu>
Date: Tue, 24 Nov 2009 23:08:52 +0000
Subject: Re: [PATCHSET 0-5] remove unneeded nfsd #includes
Message-Id: <20091124230852.GA468@fieldses.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4B0C1EB7.50508@panasas.com>
In-Reply-To: <4B0C1EB7.50508@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-parisc <linux-parisc@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, NFS list <linux-nfs@vger.kernel.org>, pNFS Mailing List <pnfs@linux-nfs.org>, Andrew Morton <akpm@linux-foundation.org>

On Tue, Nov 24, 2009 at 07:58:15PM +0200, Boaz Harrosh wrote:
> Why is debug.h exported from Kernel? (include/linux/nfsd/Kbuild)

I suppose it's so rpcdebug can get the rpc debug flags; see e.g.
nfs-utils/tools/rpcdebug/rpcdebug.c.

--b.
