From: chris hyser <chris.hyser@oracle.com>
Date: Tue, 21 Apr 2015 18:39:08 +0000
Subject: Re: [PATCH v3] sparc64: Setup sysfs to mark LDOM sockets, cores and threads correctly
Message-Id: <5536994C.2030603@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5526cf9b.DFcVpFfcq8CBXHg7%chris.hyser@oracle.com>
In-Reply-To: <5526cf9b.DFcVpFfcq8CBXHg7%chris.hyser@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 4/21/2015 2:25 PM, chris hyser wrote:
>          mp = mdesc_node_by_name(hp, MDESC_NODE_NULL, "sockets");
>          if (mp = MDESC_NODE_NULL)
> -               return set_sock_ids_by_cache(hp, mp);
> +               if (!set_sock_ids_by_cache(hp, mp, 3))
> +                       set_sock_ids_by_cache(hp, mp, 2);
>
>          return set_sock_ids_by_socket(hp, mp);

So I missed the return here. Will fix that. Surprised that even worked.

-chrish
