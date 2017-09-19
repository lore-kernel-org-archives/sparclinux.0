From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Tue, 19 Sep 2017 21:49:05 +0000
Subject: Re: [PATCH] Expose some h/w info from ILOM to userspace via sysfs
Message-Id: <3c530c9e-1e7a-41c7-a95b-6f82157591e7@default>
List-Id: <sparclinux.vger.kernel.org>
References: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
In-Reply-To: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Let me also add this: the filtering also prevents making available pieces of information that is already available on sysfs.
That's a good thing because not duplicating the same info in the kernel is paramount as you mentioned on a separate email thread today.

-eric

----- Original Message -----
From: eric.saint.etienne@oracle.com
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org
Sent: Tuesday, 19 September, 2017 10:44:20 PM GMT +00:00 GMT Britain, Ireland, Portugal
Subject: Re: [PATCH] Expose some h/w info from ILOM to userspace via sysfs

Thank you for the prompt feedback.

> Don't use uint_8_t etc. in the kernel, use u8 et al. instead.
>
> Do not use the __packed attribute unless absolutely necessary
> which seems entirely not the case for sunoem_cli_msg.

Not a problem

> Please remove the ILOM_PROFILING, you can achieve the same effect
> with tracepoints and perf.

Fair enough

> Looking at the driver from a high level, it just seems to export
> a seemingly arbitrary set of ILOM properties.  Why not provide
> a real hierarchy of all the /SYS, /HOST, etc. stuff via /sysfs?

The filtering has been added to avoid leaking confidential details such as private keys and passwords.

> The string parsing and matching in there is exactly the kind of
> code I'm talking about which doesn't belong in the kernel.

> The kernel should export a family of values for whatever (bus,
> firmware settings, etc.) transparently to the user and let them
> do whatever they want with whichever values they find interesting.

> It is not the kernel's business to filter, not interpret, the
> objects.  Yet that is what these drivers are doing.

Okay I got that but in this instance the parsing is necessary to
allow filtering, which is in turn necessary for security.

-eric
--
To unsubscribe from this list: send the line "unsubscribe sparclinux" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
