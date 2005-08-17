From: Josh Grebe <josh@brokedown.net>
Date: Wed, 17 Aug 2005 18:53:38 +0000
Subject: Re: 2.4 kernels and max # of rules with iptables
Message-Id: <430387B2.2030600@brokedown.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_unix1.shortcutsolutions.net-17392-1124304623-0001-2"
List-Id: <sparclinux.vger.kernel.org>
References: <20050619200712.036920e1@enterprise.weeve.org>
In-Reply-To: <20050619200712.036920e1@enterprise.weeve.org>
To: sparclinux@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_unix1.shortcutsolutions.net-17392-1124304623-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I guess that would help...

kmalloc failed, size of kreplsize is 939608



David S. Miller wrote:
> From: Josh Grebe <josh@brokedown.net>
> Date: Wed, 17 Aug 2005 08:06:06 -0500
> 
> 
>>I threw a little printk patch at Jason and we determined that to be 
>>correct. In do_netfilter_replace(), on about line 2924, the call
>>        krepl = (struct ipt_replace *)kmalloc(kreplsize, GFP_KERNEL);
>>results in krepl being NULL after a pile of rules have been added.
>>
>>I compiled a statically linked iptables binary and Jason was able to 
>>add over 7k rules before he stopped it, the 32 bit iptables bombs 
>>before 900 rules.
>>
>>As far as changing this behaviour, I plead ignorance.
> 
> 
> So how large was kreplsize in the failing call?
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> !DSPAM:43038246130492096615112!
> 

--=_unix1.shortcutsolutions.net-17392-1124304623-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDA4eyT/OY5rt9JCMRAyg2AJ4wbIA/4UCXD/Dk/zB9QMf5p93CTwCgrOMR
kgP7Sb7NBn2B5LpnJQMmD1o=
=kSO+
-----END PGP SIGNATURE-----

--=_unix1.shortcutsolutions.net-17392-1124304623-0001-2--
