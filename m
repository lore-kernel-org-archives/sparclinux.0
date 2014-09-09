From: David Miller <davem@davemloft.net>
Date: Tue, 09 Sep 2014 19:24:03 +0000
Subject: Re: [PATCH] sparc64: mem boot option correction
Message-Id: <20140909.122403.1305054863330225595.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410105147-23085-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410105147-23085-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Sun,  7 Sep 2014 11:52:27 -0400

> +	for_each_free_mem_range(i, any_nid, &pa_start, &pa_end, &nid) {
> +		available = available + (pa_end  - pa_start);
> +	}

Single statement basic blocks should not be enclosed with curly
braces, thanks.
