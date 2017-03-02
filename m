From: Matthew Wilcox <willy@infradead.org>
Date: Thu, 02 Mar 2017 00:12:28 +0000
Subject: Re: [PATCH v2 1/3] sparc64: NG4 memset 32 bits overflow
Message-Id: <20170302001228.GL16328@bombadil.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1488327283-177710-1-git-send-email-pasha.tatashin@oracle.com>
 <1488327283-177710-2-git-send-email-pasha.tatashin@oracle.com>
 <87h93dhmir.fsf@firstfloor.org>
 <70b638b0-8171-ffce-c0c5-bdcbae3c7c46@oracle.com>
 <20170301151910.GH26852@two.firstfloor.org>
 <6a26815d-0ec2-7922-7202-b1e17d58aa00@oracle.com>
 <20170301173136.GI26852@two.firstfloor.org>
 <1e7db21b-808d-1f47-e78c-7d55c543ae39@oracle.com>
In-Reply-To: <1e7db21b-808d-1f47-e78c-7d55c543ae39@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-mm@kvack.org, sparclinux@vger.kernel.org

On Wed, Mar 01, 2017 at 04:20:28PM -0500, Pasha Tatashin wrote:
> Hi Andi,
> 
> After thinking some more about this issue, I figured that I would not want
> to set default maximums.
> 
> Currently, the defaults are scaled with system memory size, which seems like
> the right thing to do to me. They are set to size hash tables one entry per
> page and, if a scale argument is provided, scale them down to 1/2, 1/4, 1/8
> entry per page etc.

I disagree that it's the right thing to do.  You want your dentry cache
to scale with the number of dentries in use.  Scaling with memory size
is a reasonable approximation for smaller memory sizes, but allocating
8GB of *hash table entries* for dentries is plainly ridiculous, no matter
how much memory you have.  You won't have half a billion dentries active
in most uses of such a large machine.
