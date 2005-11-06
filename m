From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sun, 06 Nov 2005 04:13:39 +0000
Subject: Re: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <1131250420.2481.66.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 2005-11-05 at 16:40 -0800, David S. Miller wrote:

> I think I missed the idea whilst trying to implement
> your suggestion, as below, but it will not compile:

Whoever "fixes" this issue, please test with module-init-tools as part
of the confirmation process. It's never fun to discover that kernel
modules just don't work.

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

