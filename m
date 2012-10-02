From: Andrea Arcangeli <aarcange@redhat.com>
Date: Tue, 02 Oct 2012 22:49:21 +0000
Subject: Re: [PATCH 6/8] mm: Make transparent huge code not depend upon the details of pgtable_t
Message-Id: <20121002224921.GR4763@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20121002.182718.250164928532772411.davem@davemloft.net>
In-Reply-To: <20121002.182718.250164928532772411.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, hannes@cmpxchg.org

Hi Dave,

On Tue, Oct 02, 2012 at 06:27:18PM -0400, David Miller wrote:
> 
> The code currently assumes that pgtable_t is a struct page pointer.
> 
> Fix this by pushing pgtable management behind arch helper functions.

This should be fixed in -mm already, it's from the s390x support.
