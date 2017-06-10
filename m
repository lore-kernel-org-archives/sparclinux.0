From: David Miller <davem@davemloft.net>
Date: Sat, 10 Jun 2017 21:33:17 +0000
Subject: Re: [PATCH v1 04/12] sparc64: expand MDESC interface
Message-Id: <20170610.173317.767785408388196635.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <214c8e29bc065cb831b81a7e3f9e0b6f27c62f81.1497024216.git.jag.raman@oracle.com>
In-Reply-To: <214c8e29bc065cb831b81a7e3f9e0b6f27c62f81.1497024216.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jag Raman <jag.raman@oracle.com>
Date: Fri,  9 Jun 2017 12:30:53 -0400

> @@ -71,6 +72,22 @@ struct mdesc_notifier_client {
>  
>  void mdesc_register_notifier(struct mdesc_notifier_client *client);
>  
> +union md_node_info {
> +	struct vdev_port {
> +		u64 id;				/* id */
> +		u64 parent_cfg_hdl;		/* parent config handle */
> +		char name[MDESC_MAX_STR_LEN];	/* name (property) */
> +	} vdev_port;
> +	struct ds_port {
> +		u64 id;				/* id */
> +	} ds_port;
> +};

You don't need to allocate stack or structure space for the name string.
Just use "const char *"

Any traversal of the MDESC must do an mdesc grab around the operation,
therefore the mdesc node property holding the string will persist and
not disappear on us.

> +u64 mdesc_get_node(struct mdesc_handle *hp, char *node_name,

Please use "const char *node_name"

> +int mdesc_get_node_info(struct mdesc_handle *hp, u64 node,
> +			char *node_name, union md_node_info *node_info);

Likewise.

> +static void mdesc_get_node_ops(char *node_name, mdesc_node_info_f *node_info_f,
> +			       mdesc_node_match_f *node_match_f)

Likewise.
