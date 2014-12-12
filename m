From: David Miller <davem@davemloft.net>
Date: Fri, 12 Dec 2014 02:44:16 +0000
Subject: Re: [PATCH v2] sparc64: sunvdc: Complete I/O request if vdisk server error
Message-Id: <20141211.214416.1552612437664125122.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <546FA956.1070005@oracle.com>
In-Reply-To: <546FA956.1070005@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: chris hyser <chris.hyser@oracle.com>
Date: Tue, 02 Dec 2014 11:53:37 -0500

> Sending it again. Thanks.

Please do not resubmit patches like a forwarded email
as you are doing here.

Submit is like a fresh, new, patch posting.

Your patch also has a few problems:

> + printk(KERN_ERR PFX "virtual disk server I/O error %d\n",
> +				desc->status);

Please use "pr_err()"

Also, on function calls that span multiple lines, you must
indent the send and subsequent lines of that function call
exactly to the column after the openning parenthesis of that
function call.

You must use the appropriate number of space and TAB characters
necessary to do so.  If you are only using TAB characters, you
are doing it wrong. :)
