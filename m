From: David Miller <davem@davemloft.net>
Date: Wed, 28 Jun 2006 18:35:41 +0000
Subject: Re: [PATCH] sparc: remove sunzilog_console_init
Message-Id: <20060628.113541.112621691.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060628141601.GA31139@palantir8>
In-Reply-To: <20060628141601.GA31139@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Wed, 28 Jun 2006 15:34:02 +0100

> It was tested on a SS20 with the console on a sunzilog.

Where does the register_console() call occur then?

Oh, it happens in the serial layer because we set
the ->cons member of sunzilog_reg right?
