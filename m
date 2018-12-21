From: David Miller <davem@davemloft.net>
Date: Fri, 21 Dec 2018 19:25:21 +0000
Subject: Re: [PATCH] serial/sunsu: fix refcount leak
Message-Id: <20181221.112521.1449281052807365475.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181212160145.23117-1-tiny.windzz@gmail.com>
In-Reply-To: <20181212160145.23117-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tiny.windzz@gmail.com
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, sparclinux@vger.kernel.org, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>
Date: Wed, 12 Dec 2018 11:01:45 -0500

> The function of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> 
> su_get_type() doesn't do that. The match node are used as an identifier
> to compare against the current node, so we can directly drop the refcount
> after getting the node from the path as it is not used as pointer.
> 
> Fix this by use a single variable and drop the refcount right after
> of_find_node_by_path().
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied.
