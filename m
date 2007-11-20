From: David Miller <davem@davemloft.net>
Date: Tue, 20 Nov 2007 07:45:00 +0000
Subject: Re: [PATCH 06/59] arch/sparc: Add missing "space"
Message-Id: <20071119.234500.127324508.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1195523331-15303-6-git-send-email-joe@perches.com>
	<ee1678e1bc8b80b7ae420059fffc7241486ea91a.1195454434.git.joe@perches.com>
	<1195523331-15303-7-git-send-email-joe@perches.com>
In-Reply-To: <1195523331-15303-7-git-send-email-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: joe@perches.com
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Mon, 19 Nov 2007 17:47:58 -0800

> Signed-off-by: Joe Perches <joe@perches.com>

Please check your patches, for trailing white "space".

Adds trailing whitespace.
diff:10:		prom_printf("PCIC: Error, cannot map " 
Adds trailing whitespace.
diff:19:		prom_printf("PCIC: Error, cannot map " 
warning: 2 lines add whitespace errors.

I've fixed it up this time.
