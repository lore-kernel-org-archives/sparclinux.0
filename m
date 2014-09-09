From: David Miller <davem@davemloft.net>
Date: Tue, 09 Sep 2014 22:20:01 +0000
Subject: Re: [PATCH] sparc64: find_node adjustment
Message-Id: <20140909.152001.1389200846458603545.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410105066-22822-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410105066-22822-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Sun,  7 Sep 2014 11:51:06 -0400

> Hopefully this isn't too confusing. I'll add the reference below for those
> with a need for further details:
> http://psarc.us.oracle.com/FWARC/2007/260/materials/lgroups_onepager.txt

"This webpage is not available", I think you can only get at this
from inside Oracle, and if so it's inappropriate to use it as a
reference in a commit message.

Anyways, as per the bug, it looks simply like node matching
information is missing sometimes.

Whilst unfortunate, you're right that we should code defensively and
not fail if that happens, especially if we know that it can.

Please respin this with the commit message adjusted, thanks.
