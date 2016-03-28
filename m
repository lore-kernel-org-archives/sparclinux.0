From: David Miller <davem@davemloft.net>
Date: Mon, 28 Mar 2016 15:46:58 +0000
Subject: Re: [PATCH 10/31] Add sparc-specific parity functions
Message-Id: <20160328.114658.1782649417123902109.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <56F8C4A3.1070808@gmail.com>
	<20160328.112915.1286498398436148099.davem@davemloft.net>
	<20160328153743.GA13061@ravnborg.org>
In-Reply-To: <20160328153743.GA13061@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: zhaoxiu.zeng@gmail.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 28 Mar 2016 17:37:43 +0200

> If popc is availble then use of hweight* should be fine.
> But without popc then I think the generic implementation that
> uses the stanford algorithm would be most efficient,
> rather than the base this on the generic hweight functions.

Agreed.
