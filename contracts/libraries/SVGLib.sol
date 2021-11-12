// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@brechtpd/base64.sol";

library SVGLib {
    
    using Strings for uint256;

    string constant svg1 = "<svg xmlns='http://www.w3.org/2000/svg' width='600px' height='600px' viewBox='0 0 360 360' fill='none' stroke='#000' stroke-width='0' stroke-linecap='round' stroke-linejoin='round'><defs><clipPath id='center' clipPathUnits='userSpaceOnUse'><circle cx='180' cy='180' r='140'/></clipPath><clipPath id='clip'><path d='M0 0h360v360H0z'/></clipPath><linearGradient id='g151' gradientUnits='userSpaceOnUse' x1='0%' y1='0%' x2='0%' y2='90%'><stop stop-color='#1589FF' offset='0'/><stop stop-color='#000' offset='1'/></linearGradient><path id='text' d='M180 26.5c84.72 0 153.5 68.78 153.5 153.5S264.72 333.5 180 333.5 26.5 264.72 26.5 180 95.28 26.5 180 26.5'/><path id='flips' d='M 69 120 C 92 86 99 80 141 60'/></defs><style> @font-face{ font-family:'AW'; src: url(data:application/font-woff2;charset=utf-8;base64,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) format('woff2');} .circle{ animation:circle 30s infinite normal linear; transform:rotate(0deg); transform-origin:180px 180px; } @keyframes circle{ from{ transform:rotate(0deg); } to{ transform:rotate(360deg); } } </style><g clip-path='url(#clip)'><path fill='#000' opacity='.1' d='M0 0h360v360H0z'/><circle cx='180' cy='180' r='180' fill='#fff'/></g><g clip-path='url(#center)' stroke-width='.5'><g><rect width='100%' height='100%' fill='black'/><rect x='0' y='60%' width='100%' height='40%' fill='url(#g151)'/><g stroke='none'><circle cx='40%' cy='32%' r='.5' fill='grey'/><circle cx='26%' cy='34%' r='.5' fill='grey'/><circle cx='34%' cy='42%' r='.5' fill='grey'/><circle cx='20%' cy='39%' r='.3' fill='grey'/><circle cx='74%' cy='42%' r='.4' fill='grey'/><circle cx='49%' cy='20%' r='.2' fill='blue'/><circle cx='55%' cy='34%' r='.4' fill='grey'/><circle cx='39%' cy='24%' r='.3' fill='grey'/><circle cx='55%' cy='14%' r='.5' fill='white'/><circle cx='60%' cy='28%' r='.6' fill='blue'/><circle cx='80%' cy='32%' r='.3' fill='yellow'/><circle cx='42%' cy='44%' r='.5' fill='grey'/></g></g><g transform='scale(0.5) translate(200 180)' stroke='none' ><circle cx='81.05%' cy='16.05%' r='33.1' fill='#53676c'/><circle cx='80.95%' cy='15.8%' r='31.2' fill='#A5B6BA'/><circle cx='80.8%' cy='15.2%' r='28.5' fill='#b7c4c8'/><circle cx='80.5%' cy='14.6%' r='24.6' fill='#dbe3e2'/><circle cx='74.3%' cy='15.2%' r='4' fill='#dbe3e2'/><circle cx='74.3%' cy='15.35%' r='2.9' fill='#b7c4c8'/><circle cx='81.9%' cy='14.2%' r='10' fill='#b7c4c8'/><circle cx='79.9%' cy='19.9%' r='8.8' fill='#dbe3e2'/><circle cx='79.5%' cy='20.5%' r='6' fill='#b7c4c8'/><circle cx='77.5%' cy='8.8%' r='2.1' fill='#dbe3e2'/><circle cx='86.2%' cy='11.2%' r='3.2' fill='#dbe3e2'/><circle cx='86.5%' cy='13.9%' r='5.1' fill='#dbe3e2'/><circle cx='86.7%' cy='13.96%' r='4.1' fill='#b7c4c8'/><circle cx='85%' cy='13.2%' r='1.5' fill='#b7c4c8'/><circle cx='82.8%' cy='17.8%' r='2.4' fill='#b7c4c8'/><circle cx='84.4%' cy='19.8%' r='3.3' fill='#dbe3e2'/><circle cx='84.5%' cy='19.8%' r='2.4' fill='#b7c4c8'/></g><g><line stroke='purple' x1='139.9%' y1='90%' x2='79.95%' y2='60%'/><line stroke='purple' x1='114.9%' y1='90%' x2='73.45%' y2='60%'/><line stroke='purple' x1='95.9%' y1='90%' x2='67.55%' y2='60%'/><line stroke='purple' x1='83.9%' y1='100%' x2='60.95%' y2='60%'/><line stroke='purple' x1='65.9%' y1='100%' x2='54.55%' y2='60%'/><line stroke='purple' x1='49.9%' y1='100%' x2='48.95%' y2='60%'/><line stroke='purple' x1='34.4%' y1='100%' x2='43.45%' y2='60%'/><line stroke='purple' x1='16.9%' y1='100%' x2='37.95%' y2='60%'/><line stroke='purple' x1='-1.3%' y1='100%' x2='31.95%' y2='60%'/><line stroke='purple' x1='-12%' y1='90%' x2='26%' y2='60%'/><line stroke='purple' x1='-37%' y1='90%' x2='20%' y2='60%'/><line stroke='blue' x1='0%' y1='61.5%' x2='100%' y2='62.5%'/><line stroke='blue' x1='0%' y1='64.5%' x2='100%' y2='65.5%'/><line stroke='blue' x1='0%' y1='70%' x2='100%' y2='71%'/><line stroke='blue' x1='0%' y1='76%' x2='100%' y2='77%'/><line stroke='blue' x1='0%' y1='82.5%' x2='100%' y2='83%'/><line stroke='blue' x1='0%' y1='89.5%' x2='100%' y2='90%'/><line stroke='blue' x1='0%' y1='97%' x2='100%' y2='98%'/><text font-family='AW' font-size='58' style='fill: #fff;' x='50%' y='59%' dominant-baseline='middle' text-anchor='middle'>";
    
    string constant svg2 = "</text></g></g><g><text font-family='AW' font-size='12' letter-spacing='3' style='fill: #fff;'><textPath href='#flips'>";
    
    string constant svg3a = " FLIPS</textPath></text></g><g class='circle'><text font-family='AW' font-size='20' letter-spacing='2.95' style='fill: ";

    string constant svg3b = ";'><textPath href='#text'>";
    
    string constant svg4 = "</textPath></text></g></svg>";

    string constant svg_yes = "YES &#160;&#160;#&#160;&#160; YES &#160;&#160;#&#160;&#160; YES &#160;&#160;#&#160;&#160; YES &#160;&#160;#&#160;&#160; YES &#160;&#160;#&#160;&#160; YES &#160;&#160;#&#160;&#160; YES &#160;&#160;#&#160;&#160; YES &#160;&#160;#&#160;&#160; YES &#160;&#160;#&#160;&#160;";
    
    string constant svg_no = "NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160; NO &#160;&#160;#&#160;&#160;";
    
    function svgToImageURI(string memory _text, bool _yesno, uint256 flips) internal view returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        // svg1, CRYPTO svg2 FLIPS svg3 YES/NO svg4
        string memory yesno = _yesno ? svg_yes : svg_no;
        string memory yesno_color = _yesno ? 'green' : 'blue';
        string memory svg = string(abi.encodePacked(svg1, _text, svg2, flips.toString(), svg3a, yesno_color, svg3b, yesno, svg4));
        string memory svgBase64Encoded = Base64.encode(bytes(abi.encodePacked(svg)));
        string memory imageURI = string(abi.encodePacked(baseURL, svgBase64Encoded));
        return imageURI;
    }

    function formatTokenURI(string memory _imageURI) internal pure returns (string memory) {
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name": "OrNo NFT",',
                            '"description": "Coolest thing on the Earth",',
                            '"attributes": "",',
                            '"image": "', _imageURI , '"}'
                        )
                    )
                )
            )
        );       
    }
}