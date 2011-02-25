From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 25 Feb 2011 06:06:06 +0000
Subject: Re: [PATCH v5] of/promtree: allow DT device matching by fixing 'name' brokenness
Message-Id: <AANLkTimc37=azh11sYYi6x7gTE=0ybud5tXgxa1TDUMT@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110224165917.3760.24493.stgit@localhost6.localdomain6>
	<20110224093341.5a809a13@queued.net>
	<20110224194234.GA8907@angua.secretlab.ca>
	<20110224120109.0ed9f473@queued.net>
In-Reply-To: <20110224120109.0ed9f473-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Feb 24, 2011 at 1:01 PM, Andres Salomon <dilinger@queued.net> wrote:
> On Thu, 24 Feb 2011 12:42:34 -0700
> Grant Likely <grant.likely@secretlab.ca> wrote:
>> If firmware is buggy, then pkg2path must deal with it. =A0It is not okay
>> for it to return NULL. =A0(I know that pkg2path is an OFW command, but
>> in this context it really means the linux wrapper to pkg2path which
>> has the semantics, "give me the unique, full and accurate path for
>> this node"). =A0If OFW pkg2path doesn't work, then the platform code
>> must work around it. =A0I'm pushing back on this because I do not want
>> to see platform workarounds in the common code.
>
> I'm fine with that, I just don't want to see BUG() happening that
> early. =A0I think a workaround should be handled in common code. =A0I agr=
ee
> that heroic workarounds for firmware bugs should be handled in
> arch-specific pkg2path hooks, but a simple workaround in common code
> is better than just crashing early in boot (imo).

Alright, you've swayed me a bit.  I've made this change and pushed it
out to devicetree/experimental.  I've also picked up your other patch.
 Let me know if it works for you.

diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
index 5ab3bd5..4d87b5d 100644
--- a/drivers/of/pdt.c
+++ b/drivers/of/pdt.c
@@ -65,17 +65,25 @@ static inline void irq_trans_init(struct device_node *d=
p) {

 static char * __init of_pdt_build_full_name(struct device_node *dp)
 {
+       static int failsafe_id =3D 0; /* for generating unique names on fai=
lure */
        char *buf;
        int len;

        if (of_pdt_prom_ops->pkg2path(dp->phandle, NULL, 0, &len))
-               BUG();
+               goto failsafe;

        buf =3D prom_early_alloc(len + 1);
-       if (!buf)
-               BUG();
        if (of_pdt_prom_ops->pkg2path(dp->phandle, buf, len, &len))
-               BUG();
+               goto failsafe;
+       return buf;
+
+ failsafe:
+       buf =3D prom_early_alloc(strlen(dp->parent->full_name) +
+                              strlen(dp->name) + 16);
+       sprintf(buf, "%s/%s@unknown%i",
+               of_node_is_root(dp->parent) ? "" : dp->parent->full_name,
+               dp->name, failsafe_id++);
+       pr_err("%s: pkg2path failed; assigning %s\n", __func__, buf);
        return buf;
 }

g.
