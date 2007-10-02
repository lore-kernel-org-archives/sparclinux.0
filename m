From: David Miller <davem@davemloft.net>
Date: Tue, 02 Oct 2007 21:27:45 +0000
Subject: Re: Bug: semctl failures on sparc64
Message-Id: <20071002.142745.113008032.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1191346088.3553.151.camel@localhost.localdomain>
In-Reply-To: <1191346088.3553.151.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 02 Oct 2007 13:28:08 -0400

> I've been trying to track down why postgresql has been failing to run
> its tests when built for sparc64, and working with Tom Lane, we've
> generated an independent test case showing that the failure seems to be
> in the kernel.
> 
> The test case is attached:

Thanks Tom I'll look into this.
