From: David Miller <davem@davemloft.net>
Date: Tue, 27 Mar 2007 23:39:41 +0000
Subject: Re: [PATCH] add unsigned to unused bit field in a.out.h
Message-Id: <20070327.163941.71554165.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1174476415.22880.14.camel@dell>
In-Reply-To: <1174476415.22880.14.camel@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: 21 Mar 2007 07:26:56 -0400

> Add unsigned to unused bit field in a.out.h to make sparse happy.

Same problems here as the cg3 patch.

Please resubmit these patches with a proper Signed-off-by:
line and fix your mail client not to corrupt the patch.
Test this by emailing the patch to yourself and trying to
apply it.

Thanks.
