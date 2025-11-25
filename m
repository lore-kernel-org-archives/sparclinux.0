Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770553770B
	for <sparclinux@vger.kernel.org>; Tue, 25 Nov 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078001; cv=none; b=tiNT2YRo3rrGmJOHyZ/OVnad6nEa1gc24p1IzKJIEUHEq2BIL5YR6F1PzPmiu5SPEoS6Tpr17fofAjhms+UZyw8SZFPbS9/Hqqm78rp+N7thicUGuAdSgaWXmFpQNk/KnYFdP6PO4KotHuaQcdCSWqTfGk1F9BIQboojtpyrfqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078001; c=relaxed/simple;
	bh=t9k46YKiR0yToOqPC8tJLWldUv3bkY2Nm4TLf+L1CEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwZWSxm2XvkqnwBK8ejKAU/afSl6QFXrxp7/1JK+Ks3VxGzvlUFUjKOg9fpsBhuKET6oQnUzQs/gzxVBnelml6Hf97rwyQvvi+sbGHNKQF9+2IRrcskW6I+LZM0JSaaB7BGinj2Kon0g6qAvPCmiPh5vP+UJ+mur4pmDx1/FjaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L508VV+r; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L508VV+r"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-645a13e2b17so4242219a12.2
        for <sparclinux@vger.kernel.org>; Tue, 25 Nov 2025 05:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764077998; x=1764682798; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t9k46YKiR0yToOqPC8tJLWldUv3bkY2Nm4TLf+L1CEI=;
        b=L508VV+rxFog9t3rX3L1ZL4DaMOKbVSrl/3oM4dK7C1RSoaqMwJTAH0bDPprn+WEaG
         qHvrTdjarKFEN7SEcR/uV9wNYJlLQecQrjZD9df+gf/3zNrcp9wpbdnHdkDVvfsjGM5K
         0JNczGRhqNDBVjgYl0Awx5GyZeAE691FlH5Z9ZoyR7iO+6L2Ea/RNwI9/E8aU6UikgrW
         bDDi+kXXqbmZn4mCcvcFn9CAfRH77jDVkC3nzxaAj3/eDqpk2Lf2ajPoTrfOKtqEOX57
         vRt2XeRSRyS4Hy57cf1ROkeRZteDAZqYBI/a90M7ctJjz+Uu3G6GWZOFTHo5e3EBj4g7
         a+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764077998; x=1764682798;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9k46YKiR0yToOqPC8tJLWldUv3bkY2Nm4TLf+L1CEI=;
        b=cKs8HwjIJRyo7QOl9BWG+PuLjzVmyusEnDycGYr9mqRmLCV95o6FxBKEjwEbzFwIq2
         h2L63zc34h+mRVHd1fNU8MaGAvIpZJOMSi4E7AF8RfU2UX3gA8c1xIKc+jlQjAvt7Lln
         OYu3ok9uRiZn/OC6Uy8CvkUKQrz+1xrxcRcXAbuDxHXk9wP+qJYag78nC3ZcZu5qWKtA
         iHiJ2aKvQyE0/Y/Xxly7VWuPdmxl3Ugh16L64Ffoumxc6+h+ZEtFD8VXcPLFeC5pGnPD
         O4cSZTObBjusFlS4fW8KoAanTKijM3fPzVrJjPBMLTzspMUjZe2jlW83609RozhnIntJ
         iEDg==
X-Forwarded-Encrypted: i=1; AJvYcCVThDJPK83M2aUlGkekCcoSKISklT1MnQR2GKpMQM5TyUigC7uw2CiSVzO4JdOJ1CzAO/ux9Ejyz/Ar@vger.kernel.org
X-Gm-Message-State: AOJu0YxovAJMeQFVWK+vWtqRDfebeQSs+rP1m1ls7dKzwAojWjasPbiI
	6HM4IddtNfbyeIuKd8LQKYZPsN5VAqTMqbCg/yjqBUnxrNy3P0fVSIHSwrMFnWSMcgw=
X-Gm-Gg: ASbGncuBavbfMVqUTnX7/l65igUgRYUuPTg0elGsIGJSjfhoaYUEM3qQdzjgmZqKDG3
	QtefOCGXYIgvWj171fOM5oGa2tC3dOJg+yF0xPTH/f/dt2UFG2Z1JUwi/ddFNlzCpdQbVJervsu
	fcl17s/R25diIoC7PcitD5eAB1V3QzaoabQ0bl3ecugC6vhe1P0KfoEJc8G8wdCDYGUi39v2u/V
	r+k00mVlCZQnP1z71d2R3aLRVq1J6vtEJEVyPJ3WYQPCXQgV4EdHihrsqsBKfKuvqTpjP7hDF+m
	sZUbOuhyNElga5NBQkM1tZaZ34FYH5VZryhD9vqxF9VrcYC7FEI6pYLl9V9972ocUGVK4XQ1z3L
	+20GiKANMDP4on8USn7kwhvzMNCE9JuHvEWYAIh151K3rwrkKjnTSCRcV74jIo8bdSFjKAM/k/i
	MfWomE/GKOTQLYb+cz8xNyvp4TXWLn7D9X4rUELfEzBqL9C6ZjfOTSj1conJmMB5WPfqiOUzfTX
	fN2rFYt08UPc+jnZZs6FwYflCp1uf+6kM7wVahcxtdfsV7v5w==
X-Google-Smtp-Source: AGHT+IFEyicFSi+PL/7sV+Rr65T6PnnmK37s9BQnogitw6aYlavVnxgivz8dWx5vdwjWsip7TwnDGQ==
X-Received: by 2002:a05:6402:1d50:b0:640:cd2a:3cc1 with SMTP id 4fb4d7f45d1cf-645eaf9e5d6mr2598230a12.0.1764077997753;
        Tue, 25 Nov 2025 05:39:57 -0800 (PST)
Received: from ?IPV6:2003:e5:871a:de00:dd24:7204:f00a:bf44? (p200300e5871ade00dd247204f00abf44.dip0.t-ipconnect.de. [2003:e5:871a:de00:dd24:7204:f00a:bf44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64536443a9csm14940329a12.29.2025.11.25.05.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 05:39:57 -0800 (PST)
Message-ID: <263d6867-bf94-40b5-87f8-96b40e797ebe@suse.com>
Date: Tue, 25 Nov 2025 14:39:56 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] x86/xen: use lazy_mmu_state when
 context-switching
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Jann Horn <jannh@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251124132228.622678-1-kevin.brodsky@arm.com>
 <20251124132228.622678-13-kevin.brodsky@arm.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20251124132228.622678-13-kevin.brodsky@arm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------aG2Ac2AfdT2tzwl0XdLF1SjN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------aG2Ac2AfdT2tzwl0XdLF1SjN
Content-Type: multipart/mixed; boundary="------------uiRZ28tjJaLdZE5TT0DoL5p0";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Jann Horn <jannh@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
Message-ID: <263d6867-bf94-40b5-87f8-96b40e797ebe@suse.com>
Subject: Re: [PATCH v5 12/12] x86/xen: use lazy_mmu_state when
 context-switching
References: <20251124132228.622678-1-kevin.brodsky@arm.com>
 <20251124132228.622678-13-kevin.brodsky@arm.com>
In-Reply-To: <20251124132228.622678-13-kevin.brodsky@arm.com>

--------------uiRZ28tjJaLdZE5TT0DoL5p0
Content-Type: multipart/mixed; boundary="------------yTa6J58m2WgehpiHUf7cxco6"

--------------yTa6J58m2WgehpiHUf7cxco6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTEuMjUgMTQ6MjIsIEtldmluIEJyb2Rza3kgd3JvdGU6DQo+IFdlIGN1cnJlbnRs
eSBzZXQgYSBUSUYgZmxhZyB3aGVuIHNjaGVkdWxpbmcgb3V0IGEgdGFzayB0aGF0IGlzIGlu
DQo+IGxhenkgTU1VIG1vZGUsIGluIG9yZGVyIHRvIHJlc3RvcmUgaXQgd2hlbiB0aGUgdGFz
ayBpcyBzY2hlZHVsZWQNCj4gYWdhaW4uDQo+IA0KPiBUaGUgZ2VuZXJpYyBsYXp5X21tdSBs
YXllciBub3cgdHJhY2tzIHdoZXRoZXIgYSB0YXNrIGlzIGluIGxhenkgTU1VDQo+IG1vZGUg
aW4gdGFza19zdHJ1Y3Q6OmxhenlfbW11X3N0YXRlLiBXZSBjYW4gdGhlcmVmb3JlIGNoZWNr
IHRoYXQNCj4gc3RhdGUgd2hlbiBzd2l0Y2hpbmcgdG8gdGhlIG5ldyB0YXNrLCBpbnN0ZWFk
IG9mIHVzaW5nIGEgc2VwYXJhdGUNCj4gVElGIGZsYWcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBLZXZpbiBCcm9kc2t5IDxrZXZpbi5icm9kc2t5QGFybS5jb20+DQoNClJldmlld2VkLWJ5
OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0K
--------------yTa6J58m2WgehpiHUf7cxco6
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------yTa6J58m2WgehpiHUf7cxco6--

--------------uiRZ28tjJaLdZE5TT0DoL5p0--

--------------aG2Ac2AfdT2tzwl0XdLF1SjN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmklsawFAwAAAAAACgkQsN6d1ii/Ey9M
5gf9EkkVr+UGKF/wariaJTMLeEayZP1qBy09TFMvwrlbuCyD1J20iKHWJ2c/xfac/xcQdvzxGK3Y
nMX8Dg+6nWgGk7tT/9p0s2dcvsYF2fnh4WI7yS6FTimnkkmwDCj9T7zl1nziZEYUlj7oSea1hRVz
v5iiijrTDLW6L4D3oVzmqLK1XGNpOTClCzJcn9gz45Pw5+8laVmiYBcktiYFOT/TcJvnIeHTH8Fx
P0/i23ndybO8Xtkp5yj+KAjX+75J2bEJOx79yOSaRu5z3yYhY2XBKE9tsxsVb7uoaIhxnhc2Z5ZH
ms+Hk03X+jeJhvbey+a5MrddNG95o9MtcKNcDmNH6g==
=ph6L
-----END PGP SIGNATURE-----

--------------aG2Ac2AfdT2tzwl0XdLF1SjN--
