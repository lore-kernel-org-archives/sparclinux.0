From: David Miller <davem@davemloft.net>
Date: Tue, 21 Jan 2020 12:24:53 +0000
Subject: Re: [PATCH] sparc32,leon: Stop adding vendor and device id to prom ambapp path components
Message-Id: <20200121.132453.376626555109959388.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200113160147.9254-1-andreas@gaisler.com>
In-Reply-To: <20200113160147.9254-1-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andreas@gaisler.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 13 Jan 2020 17:01:47 +0100

> These extra fields before the @ are not handled in of_node_name_eq,
> making commit b3e46d1a0590500335f0b95e669ad6d84b12b03a break node name
> comparisons for ambapp path components, thereby making LEON systems
> unable to boot.
> 
> As there is no need for the tacked on vendor and device ID fields in the
> path component, resolve this situation by removing them.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Applied, thanks.
