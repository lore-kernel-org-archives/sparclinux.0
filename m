From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 04 May 2004 15:39:58 +0000
Subject: Re: [PATCH] Small cleanup to kernel/setup.c
Message-Id: <20040504153957.GA4275@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040504132104.GA23807@artsapartment.org>
In-Reply-To: <20040504132104.GA23807@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, May 04, 2004 at 10:02:22AM -0500, Art Haas wrote:

> So the formatting changes are out - what about the variable removal?

I'll take that part - highest_paddr is completely useless.  Thanks.

-- 
Keith M Wesolowski
