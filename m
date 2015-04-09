From: David Miller <davem@davemloft.net>
Date: Thu, 09 Apr 2015 23:06:47 +0000
Subject: Re: [PATCH v3] sparc64: Setup sysfs to mark LDOM sockets, cores and threads correctly
Message-Id: <20150409.190647.2248866190992443610.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5526cf9b.DFcVpFfcq8CBXHg7%chris.hyser@oracle.com>
In-Reply-To: <5526cf9b.DFcVpFfcq8CBXHg7%chris.hyser@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: chris.hyser@oracle.com
Date: Thu, 09 Apr 2015 15:14:35 -0400

> +static void set_sock_ids(struct mdesc_handle *hp)
> +{
> +	u64 mp;
> +
> +	/* If machine description exposes sockets data use it.
> +	 * Otherwise fallback to use L3 cache
> +	 */
> +	mp = mdesc_node_by_name(hp, MDESC_NODE_NULL, "sockets");
> +	if (mp = MDESC_NODE_NULL)
> +		return set_sock_ids_by_cache(hp, mp);
> +
> +	return set_sock_ids_by_socket(hp, mp);
> +}
> +

How will this work on T3, T2, and T1 which all neither have the
"socket" mdesc nodes nor level 3 caches?
